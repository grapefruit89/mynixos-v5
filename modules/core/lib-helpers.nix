# ────────────────────────────────────────────────────────────────────────────────
# QUELLEN:
# - Misterio77/nix-config (Systemd-Härtung, modulare Struktur)
# - andersonjoseph/jailed-agents (PrivateUsers / network Policy)
# - denful/dendrix (Dendritisches Muster / rekursive Imports)
# - kiriwalawren/nixflix (Media-Stack Isolation)
# ────────────────────────────────────────────────────────────────────────────────
{ lib, pkgs, ... }: 
let
 # 🚀 SSoT Domain Generator
 getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";

 # 📊 TRACEABILITY V2 (ADR 220)
 mkTracedOption = src: opt: opt // { 
 description = (opt.description or "") + " [Source: ${src}]"; 
 };

 # 🛠️ BOILERPLATE REDUCER (from nixconf)
 mkOpt = type: default: description: lib.mkOption { inherit type default description; };
 mkBoolOpt = default: description: mkOpt lib.types.bool default description;
 mkEnableOption = desc: lib.mkEnableOption desc // { default = false; };

 # 🧮 LIST HELPERS
 mergeAttrsList = builtins.foldl' (a: b: a // b) { };

 # 📂 RECURSIVE IMPORTER (Dendritic Pattern)
 # Traverses a directory tree and returns a list of all .nix files (excluding default.nix).
 recursiveImportDir = dir: let
   # Read the directory content
   content = builtins.readDir dir;
   
   # Process entries
   processEntry = name: type: let
     path = dir + "/${name}";
   in
     if type == "directory" then
       recursiveImportDir path
     else if type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" && !(lib.hasPrefix "_" name) then
       [ path ]
     else
       [];
   
   # Flatten the list of lists
   allEntries = lib.mapAttrsToList processEntry content;
 in
   lib.flatten allEntries;

in rec {
  inherit mkTracedOption mkOpt mkBoolOpt recursiveImportDir;

  # --- INTERNAL HELPERS (KISS) ---
  
  # Generates a hardened systemd serviceConfig
  mkSystemdConfig = { name, isHardened, staticUid, requiresPostgres, readWritePaths, readOnlyPaths, extraServiceConfig, finalNetns, appDataDir, appCacheDir, stateDir, tailscaleOnly, network, useGPU }: lib.recursiveUpdate {
    # --- Hardened Production Baseline (v7.0 Strict - Audit Topic 9) ---
    # These settings apply to EVERY service wrapped in mkService.
    ProtectSystem = "strict";
    ProtectHome = true;
    PrivateTmp = true;
    PrivateIPC = true;
    NoNewPrivileges = true;
    CapabilityBoundingSet = ""; # LHF-03: Drop all capabilities by default
    AmbientCapabilities = "";
    UMask = "0077";             # LHF-03: Restrict file creation permissions
    LockPersonality = true;
    RestrictNamespaces = true;
    SystemCallFilter = [
      "@system-service"
      "~@privileged"
      "~@resources"
      "~@clock"
      "~@cpu-emulation"
      "~@debug"
      "~@obsolete"
      "~@module"
      "~@mount"
      "~@raw-io"
      "~@reboot"
      "~@swap"
    ];

    # Kernel Protection
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    # Process Isolation
    ProtectClock = true;
    ProtectHostname = true;
    ProtectProc = "invisible";
    ProcSubset = "pid";
    MemoryDenyWriteExecute = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    # Network & System Sandbox
    PrivateMounts = true;
    SystemCallArchitectures = "native";
    RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
    
    # 👤 IDENTITY & DEVICE HARDENING (jailed-agents pattern)
    PrivateUsers = true;
    PrivateDevices = if useGPU then false else true;
    
    InaccessiblePaths = [
      "-+/sys/kernel/debug"
      "-+/sys/kernel/tracing"
      "-+/boot"
    ];
    
    # 👤 IDENTITY HARDENING (ADR 005)
    DynamicUser = if isHardened then false else true;
    User = if isHardened then name else null;
    
    # 🌐 NETWORK & MEMORY HARDENING (v6.1 RAM Isolation)
    PrivateNetwork = if (network == "none" && finalNetns == null) then true else false;
    IPAddressDeny = "any";
    IPAddressAllow = if network == "tailscale" then [ "100.64.0.0/10" "fd7a:115c:a1e0::/48" ]
                    else if network == "full" then "any"
                    else [];
    MemoryHigh = "500M";
    MemoryMax = "1G";

    # 💾 PERSISTENCE
    ReadWritePaths = readWritePaths ++ [ 
      appDataDir 
      appCacheDir
      stateDir
    ];
    ReadOnlyPaths = readOnlyPaths;

    # 🐘 Conditional Postgres Access
    BindPaths = lib.optional requiresPostgres "/run/postgresql";
    
    # 🌐 VPN CONFINEMENT
    NetworkNamespacePath = lib.mkIf (finalNetns != null) "/var/run/netns/${finalNetns}";
  } extraServiceConfig;

  # Generates Caddy virtualHost config
  mkCaddyConfig = { useSSO, isStream, targetUrl }: {
    extraConfig = let
      proxyCommand = if isStream then "import proxy_stream ${targetUrl}" else "reverse_proxy ${targetUrl}";
    in ''
      # Global-Access: Strict SSO for everyone (including LAN)
      ${lib.optionalString useSSO "import family_auth"}
      ${proxyCommand}
    '';
  };

  # 🏆 HARDENED SERVICE FACTORY (anchor: mkHardenedService)
  mkService = {

    config,
    name,
    port ? null,
    description ? "Hardened Production Service",
    useSSO ? true,
    useVPN ? false,
    useZeroTrustSecrets ? false,
    tailscaleOnly ? false,
    network ? "full",
    useGPU ? false,
    netns ? null,
    requiresPostgres ? false,
    isStream ? false,
    readWritePaths ? [],
    readOnlyPaths ? [],
    persist ? true,
    socket ? null,
    extraServiceConfig ? {},
  }: let
    hostName = getDomain config name;
    svcRegistry = config.my.services.spec.${name} or {};
    registrySocket = svcRegistry.socket or null;
    registryPort = svcRegistry.port or port;
    
    finalNetwork = if tailscaleOnly then "tailscale" else network;

    finalSocket = if (lib.isString socket) then socket 
                  else if registrySocket != null then registrySocket
                  else if socket == true then "/run/service-sockets/${name}.sock"
                  else null;

    targetUrl = if finalSocket != null then "unix/${finalSocket}" else "127.0.0.1:${toString registryPort}";
    srePaths = config.my.configs.paths;
    staticUid = config.my.users.registry.${name} or null;
    isHardened = staticUid != null;
    finalNetns = if useVPN then (if netns != null then netns else "vpn-${name}") else null;
    
    appDataDir = "${srePaths.appData}/${name}";
    appCacheDir = "${srePaths.appCache}/${name}";
    stateDir = "${srePaths.stateDir}/${name}";

  in {
    # 📝 1. SYSTEMD SERVICE
    systemd.services."${name}" = {
      inherit description;
      after = [ "network.target" ] 
              ++ (lib.optional (finalNetns != null) "netns-${finalNetns}.service")
              ++ (lib.optional (finalNetwork == "tailscale") "tailscaled.service")
              ++ (lib.optional useZeroTrustSecrets "secrets-decryptor.service");
      bindsTo = (lib.optional (finalNetns != null) "netns-${finalNetns}.service")
                ++ (lib.optional (finalNetwork == "tailscale") "tailscaled.service")
                ++ (lib.optional useZeroTrustSecrets "secrets-decryptor.service");
      
      serviceConfig = (mkSystemdConfig {
        inherit name isHardened staticUid requiresPostgres readWritePaths readOnlyPaths extraServiceConfig finalNetns useGPU appDataDir appCacheDir stateDir;
        network = finalNetwork;
      }) // (lib.optionalAttrs useZeroTrustSecrets {
        EnvironmentFile = [ "/run/secrets/secrets.env" ];
      });
    };

    # 💾 2. PERSISTENCE (Automated via mkService)
    my.persistence.directories = lib.mkIf persist [
      appDataDir
      appCacheDir
      stateDir
    ];

    # 👤 3. USER/GROUP
    users.users = lib.mkIf isHardened {
      "${name}" = {
        isSystemUser = true;
        group = if (name == "postgres" || name == "caddy" || name == "valkey") then name else "media";
        uid = staticUid;
      };
    };

    users.groups = lib.mkIf (isHardened && (name == "postgres" || name == "caddy" || name == "valkey")) {
      "${name}" = {};
    };

    # 🌐 3. CADDY PROXY
    services.caddy.virtualHosts."${hostName}" = mkCaddyConfig { inherit useSSO isStream targetUrl; };

    # 📊 4. TRACEABILITY
    my.meta.${name} = { id = "NIXH-AUTO-${name}"; title = description; layer = 60; audit.last_reviewed = "2026-05-10"; };

    # 🛡️ 5. SOCKET PERMISSIONS
    users.users.caddy.extraGroups = lib.optional (finalSocket != null) name;
    systemd.tmpfiles.rules = lib.optional (finalSocket != null) "d /run/service-sockets 0775 root media -";
  };

  # 🎬 HARDENED STREAMER FACTORY
  mkStreamer = {
    config,
    name,
    port,
    useGPU ? false,
    persist ? true,
    memoryMax ? "2G",
    cpuWeight ? 80,
    oomScoreAdjust ? 400,
    description ? "Streaming Service",
    useVPN ? false,
    extraServiceConfig ? {},
  }: let
    srePaths = config.my.configs.paths;
    stateDir = "${srePaths.stateDir}/${name}";
    cacheDir = "${srePaths.appCache}/${name}";
    mediaDir = srePaths.mediaLibrary;
  in (lib.mkMerge [
    (config.myLib.mkService {
      inherit config name port description persist useVPN;
      isStream = true;
      readWritePaths = [ cacheDir ];
      readOnlyPaths = [ mediaDir ];
      extraServiceConfig = lib.recursiveUpdate {
        Restart = "always";
        RestartSec = "5s";
        MemoryMax = memoryMax;
        MemoryHigh = "1.5G"; # Hardened Limit for Streaming (Baseline)
        CPUWeight = cpuWeight;
        OOMScoreAdjust = oomScoreAdjust;
        PrivateDevices = if useGPU then lib.mkForce false else true;
        DeviceAllow = if useGPU then [ "/dev/dri/renderD128 rw" ] else [];
      } extraServiceConfig;
    })
    {
      systemd.tmpfiles.rules = [
        "d ${stateDir} 0750 ${name} media -"
        "d ${cacheDir} 0775 ${name} media -"
      ];
      services.${name} = lib.optionalAttrs (name == "jellyfin") {
        dataDir = stateDir;
        inherit cacheDir;
      };
    }
  ]);
}

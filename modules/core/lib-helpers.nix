{ lib, pkgs, ... }: 
let
 # 🚀 SSoT Domain Generator
 getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";

 # 📊 TRACEABILITY V2 (ADR 220)
 mkTracedOption = src: opt: opt // { 
 description = (opt.description or "") + " [Source: ${src}]"; 
 };

in rec {
  inherit mkTracedOption;

  # --- INTERNAL HELPERS (KISS) ---
  
  # Generates a hardened systemd serviceConfig
  mkSystemdConfig = { name, isHardened, staticUid, requiresPostgres, readWritePaths, extraServiceConfig, finalNetns, appDataDir, appCacheDir, stateDir }: lib.recursiveUpdate {
    # --- Hardened Production Baseline (v7.0 Strict - Audit Topic 9) ---
    # These settings apply to EVERY service wrapped in mkService.
    ProtectSystem = "strict";
    ProtectHome = true;
    PrivateTmp = true;
    NoNewPrivileges = true;
    LockPersonality = true;
    RestrictNamespaces = true;
    SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];

    # Kernel Protection
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    # Process Isolation
    ProtectClock = true;
    ProtectHostname = true;
    MemoryDenyWriteExecute = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    # Network & System Sandbox
    PrivateMounts = true;
    SystemCallArchitectures = "native";
    
    # 👤 IDENTITY HARDENING (ADR 005)
    DynamicUser = if isHardened then false else true;
    User = if isHardened then name else null;
    UMask = "0077";
    
    # 🌐 NETWORK & MEMORY HARDENING (v6.1 RAM Isolation)
    IPAddressDeny = "any";
    MemoryHigh = "500M";
    MemoryMax = "1G";

    # 💾 PERSISTENCE
    ReadWritePaths = readWritePaths ++ [ 
      appDataDir 
      appCacheDir
      stateDir
    ];

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

  # 🏆 HARDENED SERVICE FACTORY (mkService)
  mkService = {
    config,
    name,
    port ? null,
    description ? "Hardened Production Service",
    useSSO ? true,
    useVPN ? false,
    netns ? null,
    requiresPostgres ? false,
    isStream ? false,
    readWritePaths ? [],
    persist ? true,
    socket ? null,
    extraServiceConfig ? {},
  }: let
    hostName = getDomain config name;
    svcRegistry = config.my.services.spec.${name} or {};
    registrySocket = svcRegistry.socket or null;
    registryPort = svcRegistry.port or port;

    finalSocket = if (lib.isString socket) then socket 
                  else if registrySocket != null then registrySocket
                  else if socket == true then "/run/service-sockets/${name}.sock"
                  else null;

    targetUrl = if finalSocket != null then "unix/${finalSocket}" else "127.0.0.1:${toString registryPort}";
    srePaths = config.my.configs.paths;
    staticUid = config.my.users.registry.${name} or null;
    isHardened = staticUid != null;
    finalNetns = if useVPN then (if netns != null then netns else "vpn-${name}") else null;
    
  in {
    # 📝 1. SYSTEMD SERVICE
    systemd.services."${name}" = {
      inherit description;
      after = [ "network.target" ] ++ (lib.optional (finalNetns != null) "netns-${finalNetns}.service");
      bindsTo = lib.optional (finalNetns != null) "netns-${finalNetns}.service";
      
      serviceConfig = mkSystemdConfig {
        inherit name isHardened staticUid requiresPostgres readWritePaths extraServiceConfig finalNetns;
        appDataDir = "${srePaths.appData}/${name}";
        appCacheDir = "${srePaths.appCache}/${name}";
        stateDir = "${srePaths.stateDir}/${name}";
      };
    };

    # 👤 2. USER/GROUP
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
      readWritePaths = [ cacheDir mediaDir ];
      extraServiceConfig = lib.recursiveUpdate {
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
        Restart = "always";
        RestartSec = "5s";
        MemoryMax = memoryMax;
        MemoryHigh = "75%";
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

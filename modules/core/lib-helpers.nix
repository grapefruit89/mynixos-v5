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

  # 🏆 AVIATION-GRADE SERVICE FACTORY (mkService)
  # Standard-Wrapper für alle Dienste mit Hardening, Caddy & ABC-Tiering.
  mkService = {
    config,
    name,
    port ? null, # Now optional
    description ? "Aviation-Grade Service",
    useSSO ? true,
    useVPN ? false, # 🔥 Neu: VPN-Namespace Support
    netns ? null,   # Expliziter Namespace-Name
    requiresPostgres ? false, # 🔥 NEW: Conditional Postgres access
    isStream ? false,
    readWritePaths ? [],
    persist ? true,
    socket ? null,  # Can be explicitly provided path or boolean (legacy)
    extraServiceConfig ? {},
  }: let
    hostName = getDomain config name;
    
    # Resolve from SSoT registry if available
    svcRegistry = config.my.services.spec.${name} or {};
    registrySocket = svcRegistry.socket or null;
    registryPort = svcRegistry.port or port;

    # Determine final upstream (Socket > Registry Socket > Registry Port > Port)
    # 🚀 v6.0 Strategy: Favor Unix Sockets over TCP.
    finalSocket = if (lib.isString socket) then socket 
                  else if registrySocket != null then registrySocket
                  else if socket == true then "/run/service-sockets/${name}.sock"
                  else null;

    # TCP is strictly local fallback
    targetUrl = if finalSocket != null 
                then "unix/${finalSocket}" 
                else "127.0.0.1:${toString registryPort}";

    srePaths = config.my.configs.paths;
    
    # 🚀 NEW: ABC-Tiering Path Distribution
    # Databases & State -> Tier A (NVMe)
    # Caches & Temp -> Tier B (SSD)
    appDataDir = "${srePaths.appData}/${name}";
    appCacheDir = "${srePaths.appCache}/${name}";
    
    # 👤 Static UID resolve (from users-registry.nix)
    staticUid = config.my.users.registry.${name} or null;
    isHardened = staticUid != null;
    
    # VPN-Logik (Source: nixarr / Maroka-chan)
    finalNetns = if useVPN then (if netns != null then netns else "vpn-${name}") else null;
    
  in {
    # 📝 1. SYSTEMD SERVICE OVERRIDES
    systemd.services."${name}" = {
      inherit description;
      after = [ "network.target" ] ++ (lib.optional (finalNetns != null) "netns-${finalNetns}.service");
      bindsTo = lib.optional (finalNetns != null) "netns-${finalNetns}.service";
      
      serviceConfig = lib.recursiveUpdate {
        # 🛡️ TITANIUM HARDENING (ADR 001)
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectClock = true;
        LockPersonality = true;
        RestrictNamespaces = true;
        SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
        PrivateTmp = true;
        NoNewPrivileges = true;
        
        # 👤 IDENTITY HARDENING (ADR 005)
        # Use static UIDs for nftables filtering; fallback to DynamicUser for low-risk apps.
        DynamicUser = if isHardened then false else true;
        User = if isHardened then name else null;
        UMask = "0077"; # Aviation-Grade Default
        
        # 💾 PERSISTENCE (Tier A vs Tier B)
        # Note: StateDirectory is managed by systemd, we link it via bind-mounts or explicit paths
        ReadWritePaths = readWritePaths ++ [ 
          appDataDir 
          appCacheDir
          "${srePaths.stateDir}/${name}" 
        ];

        # 🐘 Conditional Postgres Access
        BindPaths = lib.optional requiresPostgres "/run/postgresql";
        
        # 🌐 VPN CONFINEMENT
        NetworkNamespacePath = lib.mkIf (finalNetns != null) "/var/run/netns/${finalNetns}";
      } extraServiceConfig;
    };

    # 👤 6. USER/GROUP DEFINITION (if static UID)
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

    # 🌐 2. CADDY REVERSE PROXY
    services.caddy.virtualHosts."${hostName}" = {
      extraConfig = let
        proxyCommand = if isStream then "import proxy_stream ${targetUrl}" else "reverse_proxy ${targetUrl}";
      in ''
        # Global-Access: Strict SSO for everyone (including LAN)
        ${lib.optionalString useSSO "import family_auth"}
        ${proxyCommand}
      '';
    };

    # 📊 4. TRACEABILITY
    my.meta.${name} = {
      id = "NIXH-AUTO-${name}";
      title = description;
      layer = 60;
      audit.last_reviewed = "2026-04-27";
    };

    # 🛡️ 5. SOCKET PERMISSIONS: Give Caddy access to the service group
    users.users.caddy.extraGroups = lib.optional (finalSocket != null) name;

    systemd.tmpfiles.rules = lib.optional (finalSocket != null) "d /run/service-sockets 0775 root media -";
  };

  # 🎬 AVIATION-GRADE STREAMER FACTORY
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
  }: let
    srePaths = config.my.configs.paths;
    stateDir = "${srePaths.stateDir}/${name}";
    cacheDir = "${srePaths.tierB}/cache/${name}";
    mediaDir = srePaths.mediaLibrary;
  in (lib.mkMerge [
    (config.myLib.mkService {
      inherit config name port description persist useVPN;
      isStream = true;
      readWritePaths = [ cacheDir mediaDir ];
      extraServiceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
        # Resilience: Automatic restart with backoff
        Restart = "always";
        RestartSec = "5s";
        # C-04 Safeguard: Strict memory limits for all streamers
        MemoryMax = memoryMax;
        MemoryHigh = "75%"; # Gentle throttling before hard kill
        CPUWeight = cpuWeight;
        OOMScoreAdjust = oomScoreAdjust;
        PrivateDevices = if useGPU then lib.mkForce false else true;
        DeviceAllow = if useGPU then [ "/dev/dri/renderD128 rw" ] else [];
      };
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

 SystemCallFilter = [
 "@system-service"
 "~@clock @cpu-emulation @debug @module @mount @raw-io @reboot @swap @obsolete @privileged @keyring"
 ];
 SystemCallErrorNumber = "EPERM";
 UMask = "0077";
 };
 in {
 systemd.services.${name}.serviceConfig = lib.mkMerge [
 base
 (lib.optionalAttrs gpuAccess {
 PrivateDevices = false;
 DeviceAllow = [ "/dev/dri" "char-render" ];
 })
 (lib.optionalAttrs serialAccess {
 PrivateDevices = false;
 DeviceAllow = [ "/dev/ttyUSB*" "/dev/serial" ];
 })
 { ReadWritePaths = readWritePaths; }
 extraConfig
 ];
 };
}
      systemd.tmpfiles.rules = [
        "d ${stateDir} 0750 ${name} media -"
        "d ${consumeDir} 0775 ${name} media -"
        "d ${mediaDir} 0775 ${name} media -"
        "d ${cacheDir} 0750 ${name} media -"
      ];
    }
  ]);
}
 0775 ${name} media -"
        "d ${mediaDir} 0775 ${name} media -"
        "d ${cacheDir} 0750 ${name} media -"
      ];
    }
  ]);
}
      systemd.tmpfiles.rules = [
        "d ${stateDir} 0750 ${name} media -"
        "d ${consumeDir} 0775 ${name} media -"
        "d ${mediaDir} 0775 ${name} media -"
        "d ${cacheDir} 0750 ${name} media -"
      ];
    }
  ]);
}

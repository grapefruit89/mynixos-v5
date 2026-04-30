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
    port,
    description ? "Aviation-Grade Service",
    useSSO ? true,
    useVPN ? false, # 🔥 Neu: VPN-Namespace Support
    netns ? null,   # Expliziter Namespace-Name
    isStream ? false,
    readWritePaths ? [],
    persist ? true,
    socket ? false,
    extraServiceConfig ? {},
  }: let
    hostName = getDomain config name;
    targetUrl = if socket then "unix//run/service-sockets/${name}.sock" else "localhost:${toString port}";
    srePaths = config.my.configs.paths;
    
    # 🚀 NEW: ABC-Tiering Path Distribution
    # Databases & State -> Tier A (NVMe)
    # Caches & Temp -> Tier B (SSD)
    appDataDir = "${srePaths.appData}/${name}";
    appCacheDir = "${srePaths.appCache}/${name}";
    
    # VPN-Logik (Source: nixarr / Maroka-chan)
    finalNetns = if useVPN then (if netns != null then netns else "vpn-${name}") else null;
    
  in {
    # 📝 1. SYSTEMD SERVICE OVERRIDES
    systemd.services."${name}" = {
      inherit description;
      after = [ "network.target" ] ++ (lib.optional (finalNetns != null) "netns-${finalNetns}.service");
      bindsTo = lib.optional (finalNetns != null) "netns-${finalNetns}.service";
      
      serviceConfig = lib.mkMerge [
        {
          # 🛡️ TITANIUM HARDENING (ADR 001)
          ProtectSystem = "strict";
          ProtectHome = true;
          PrivateTmp = true;
          NoNewPrivileges = true;
          
          # 💾 PERSISTENCE (Tier A vs Tier B)
          ReadWritePaths = [ 
            appDataDir 
            appCacheDir
            "/var/lib/${name}" 
          ] ++ readWritePaths;
          
          # 🌐 VPN CONFINEMENT
          NetworkNamespacePath = lib.mkIf (finalNetns != null) "/var/run/netns/${finalNetns}";
        }
        extraServiceConfig
      ];
    };

    # 🌐 2. CADDY REVERSE PROXY
    services.caddy.virtualHosts."${hostName}" = {
      extraConfig = let
        proxyCommand = if isStream then "import proxy_stream ${targetUrl}" else "reverse_proxy ${targetUrl}";
      in ''
        # Global-Access: Strict SSO for everyone (including LAN)
        ${lib.optionalString useSSO "import sso_auth"}
        ${proxyCommand}
      '';
    };

    # 💾 3. IMPERMANENCE (Tier A)
    environment.persistence."/persist" = lib.mkIf persist {
      directories = [ "/var/lib/${name}" ];
    };

    # 📂 4. DIRECTORY CREATION (ADR 044)
    systemd.tmpfiles.rules = [
      "d ${appDataDir} 0750 ${name} media -"
      "d ${appCacheDir} 0750 ${name} media -"
    ];

    # 📊 5. TRACEABILITY
    my.meta.${name} = {
      id = "NIXH-AUTO-${name}";
      title = description;
      layer = 60;
      audit.last_reviewed = "2026-04-27";
    };
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
    (mkService {
      inherit config name port description persist useVPN;
      isStream = true;
      readWritePaths = [ cacheDir mediaDir ];
      extraServiceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
        # C-04 Safeguard: Strict memory limits for all streamers
        MemoryMax = memoryMax;
        MemoryHigh = "85%"; # Gentle throttling before hard kill
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

  # 📄 AVIATION-GRADE DOCUMENT APP FACTORY
  mkDocumentApp = {
    config,
    name,
    port,
    description ? "Document Management Service",
    useValkey ? false,
    usePostgres ? true,
    memoryMax ? "2G",
    cpuWeight ? 50,
    oomScoreAdjust ? 400,
    persist ? true,
    ocrLanguages ? ["deu" "eng"],
    workerCount ? 2,
    secretFile ? null,
  }: let
    srePaths = config.my.configs.paths;
    stateDir = "${srePaths.stateDir}/${name}";
    consumeDir = "${srePaths.tierC}/consume/${name}";
    mediaDir = "${srePaths.mediaLibrary}/documents/${name}";
    cacheDir = "${srePaths.tierB}/cache/${name}";
    pythonHardening = {
      MemoryDenyWriteExecute = false;
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
    };
  in (lib.mkMerge [
    (mkService {
      inherit config name port description persist;
      useSSO = true;
      readWritePaths = [ stateDir consumeDir mediaDir cacheDir ];
      extraServiceConfig = pythonHardening // {
        MemoryMax = memoryMax;
        inherit oomScoreAdjust;
        CPUWeight = cpuWeight;
        LoadCredential = lib.optional (secretFile != null) "${lib.toUpper name}_SECRET_KEY:${toString secretFile}";
      };
    })
    {
      systemd.services."${name}-worker" = {
        inherit description;
        after = [ "network.target" "redis-${name}.service" "postgresql.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = lib.recursiveUpdate pythonHardening {
          User = name;
          Group = "media";
          ExecStart = "${config.services.${name}.package}/bin/celery -A ${name} worker -l info -c ${toString workerCount}";
          Restart = "always";
          ReadWritePaths = [ stateDir consumeDir mediaDir cacheDir ];
          MemoryMax = memoryMax; # 🚀 Resource limit for worker
        };
      };
      systemd.services."${name}-beat" = {
        description = "${description} Scheduler";
        after = [ "network.target" "${name}-worker.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = lib.recursiveUpdate pythonHardening {
          User = name;
          Group = "media";
          ExecStart = "${config.services.${name}.package}/bin/celery -A ${name} beat -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler";
          Restart = "always";
          ReadWritePaths = [ stateDir ];
          MemoryMax = "256M"; # 🚀 Beat is lightweight
        };
      };
      services.postgresql = lib.mkIf usePostgres {
        ensureDatabases = [ name ];
        ensureUsers = [ { name = name; ensureDBOwnership = true; } ];
      };
      services.redis.servers.${name} = lib.mkIf useValkey {
        enable = true;
        package = pkgs.valkey;
        port = 0;
        unixSocket = "/run/redis-${name}/redis.sock";
        unixSocketPerm = 660;
      };
      systemd.tmpfiles.rules = [
        "d ${stateDir} 0750 ${name} media -"
        "d ${consumeDir} 0775 ${name} media -"
        "d ${mediaDir} 0775 ${name} media -"
        "d ${cacheDir} 0750 ${name} media -"
      ];
    }
  ]);

  # 🛡️ TITANIUM HARDENED SERVICE FACTORY (mkHardenedService)
  # Ultra-secure wrapper with strict systemd sandboxing.
  mkHardenedService = { 
    name, 
    extraConfig ? {}, 
    gpuAccess ? false, 
    serialAccess ? false, 
    readWritePaths ? [] 
  }: let
    base = {
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      MemoryDenyWriteExecute = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      LockPersonality = true;
      RestrictNamespaces = true;

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

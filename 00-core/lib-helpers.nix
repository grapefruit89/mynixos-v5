{lib, ...}: let
  # SSoT Domain Generator
  getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
in {
  mkService = {
    config,
    name,
    port ? null,
    useSSO ? true,
    description ? "Managed Service",
    netns ? null,
    extraServiceConfig ? {},
    readWritePaths ? [],
  }: let
    # Port aus SSoT ports.nix holen, falls nicht explizit übergeben
    finalPort = if port != null then port else config.my.ports.${name};
    
    # Target URL (VPN-Netns Support)
    targetUrl = "http://${if netns != null then "10.200.1.2" else "127.0.0.1"}:${toString finalPort}";
    
    # FQDN generieren
    hostName = getDomain config name;
  in {
    # 🛡️ Systemd Hardening & Sandboxing
    systemd.services.${name} = {
      inherit description;
      serviceConfig = lib.recursiveUpdate {
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
        ReadWritePaths = readWritePaths;
      } extraServiceConfig;
    };

    # 🌐 Caddy Reverse Proxy (Aviation-Grade)
    services.caddy.virtualHosts."${hostName}" = {
      extraConfig = ''
        # Vertrauenswürdiges lokales Netzwerk ohne SSO
        @trusted_network {
          remote_ip ${config.my.configs.network.lanCidr}
        }
        
        handle @trusted_network {
          reverse_proxy ${targetUrl}
        }

        # Externer Zugriff mit SSO Schutz
        ${lib.optionalString useSSO "import sso_auth"}
        reverse_proxy ${targetUrl}
      '';
    };
  };
}

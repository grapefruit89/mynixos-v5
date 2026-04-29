{
  lib,
  config,
  pkgs,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Security)
  nms = {
    id = "NIXH-00-COR-032";
    title = "SSH (Post-Quantum Hardened)";
    description = "Hardened SSH daemon with Post-Quantum cryptography, strict CIDR-based forwarding and legal protections.";
    layer = 00;
    nixpkgs.category = "system/networking";
    capabilities = ["security/ssh" "network/hardening" "crypto/post-quantum"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
    source_repo = "grapefruit89/mynixos";
  };
  
  # SSoT Integration
  sshPort = config.my.ports.ssh;
  user = config.my.configs.identity.user;
  lanCidr = config.my.configs.network.lanCidr;
in {
  options.my.meta.ssh = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

  config = {
    services.openssh = {
      enable = true;
      openFirewall = false; # 🛡️ Firewall wird separat in firewall.nix geregelt
      ports = [ sshPort ]; # 💎 Nur der Custom Port aus SSoT erlaubt

      # ⚖️ AVIATION-GRADE LEGAL BANNER
      banner = ''
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        NIXOS AVIATION-GRADE COCKPIT [v4.2]
        UNAUTHORIZED ACCESS IS PROHIBITED BY POLICY NIXH-90-POL-001
        System Owner: ${user} | Domain: ${config.my.configs.identity.domain}
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      '';

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitEmptyPasswords = false;
        AllowUsers = [ user ];
        LogLevel = "VERBOSE";
        LoginGraceTime = 20;
        MaxAuthTries = 2;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
        X11Forwarding = false;

        # 🏎️ POST-QUANTUM CRYPTO (Aligned with SRE Standards)
        KexAlgorithms = [
          "sntrup761x25519-sha512@openssh.com" # Post-Quantum champion
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
        ];
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
        ];
      };

      # 🌍 INTERNAL ACCESS POLICY (SSH Forwarding nur für vertrauenswürdige IPs)
      extraConfig = ''
        Match Address 127.0.0.1,::1,${lanCidr}
          AllowTcpForwarding yes
          GatewayPorts yes
      '';
    };

    # 🛡️ SYSTEMD HARDENING
    systemd.services.sshd = {
      stopIfChanged = false; # Verhindert SSH-Verlust bei Updates
      serviceConfig = {
        Restart = "always";
        RestartSec = "5s";
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = "read-only";
      };
    };
  };
}

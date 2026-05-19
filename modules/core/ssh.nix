# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-COR-SSH-001",
#   "title": "SSH (Post-Quantum Hardened)",
#   "layer": 0,
#   "category": "system/networking",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 3,
#   "tags": ["ssh", "hardening", "post-quantum", "remote-access"],
#   "description": "Hardened SSH daemon with Post-Quantum cryptography and strict CIDR-based forwarding."
# }
# ---ENDNIXMETA

{
 lib,
 config,
 pkgs,
 ...
}:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-031";
    title = "Hardened SSH (Post-Quantum)";
    description = "Hardened SSH daemon with Post-Quantum cryptography and strict CIDR-based forwarding.";
    layer = 0;
    nixpkgs.category = "system/networking";
    capabilities = ["ssh/hardening" "security/post-quantum" "network/remote-access"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 3;
  };
in
{
  options.my.meta.ssh = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

 config = {
 # 🛡️ SSH HARDENING (anchor: ssh-hardening)
 services.openssh = {

 enable = true;
 openFirewall = false; # 🛡️ Firewall wird separat in firewall.nix geregelt
 ports = [ sshPort ]; # 💎 Nur der Custom Port aus SSoT erlaubt

 # ⚖️ hardened LEGAL BANNER
 banner = ''
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 NIXOS hardened COCKPIT [v4.2]
 UNAUTHORIZED ACCESS IS PROHIBITED BY POLICY NIXH-90-POL-001
 System Owner: ${user} | Domain: ${config.my.configs.identity.domain}
 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 '';

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AllowUsers = [ user ];
        LogLevel = "VERBOSE";
        PubkeyAcceptedAlgorithms = let
          hermetic = config.my.security.hermetic or { enable = false; enforceHardwareKeys = false; };
          enforce = hermetic.enable && hermetic.enforceHardwareKeys;
        in if enforce then [
          "sk-ssh-ed25519@openssh.com"
          "sk-ssh-ed25519-cert-v01@openssh.com"
        ] else [
          "ssh-ed25519-cert-v01@openssh.com"
          "ssh-ed25519"
          "sk-ssh-ed25519@openssh.com" # 🛡️ YubiKey Hardware Bound
        ];
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
   RestartSec = config.my.configs.systemd.restartSec;
   ProtectProc = "invisible";
   ProcSubset = "pid";
   PrivateTmp = true;
   ProtectSystem = "strict";
   ProtectHome = "read-only";
 };
 };

 # 🔑 YUBIKEY SUPPORT
 systemd.services.pcscd.enable = lib.mkForce true;
 };
 }

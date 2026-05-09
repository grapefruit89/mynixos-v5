{
 config,
 pkgs,
 lib,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Security)
 nms = {
 id = "NIXH-00-COR-010";
 title = "Fail2ban (Edge Hardened)";
 description = "Aggressive protection with deep Caddy JSON log inspection and incremental banning logic.";
 layer = 00;
 nixpkgs.category = "services/security";
 capabilities = ["security/bruteforce-protection" "network/hardening" "caddy/security"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 # SSoT Integration
 sshPort = toString config.my.ports.ssh;
in {
 options.my.meta.fail2ban = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.fail2ban.enable or true) {
 services.fail2ban = {
 enable = true;
 # 🛡️ GLOBAL HARDENING (NFTables Standard)
 banaction = "nftables-multiport";
 banaction-allports = "nftables-allports";
 
 # Schutz gegen Selbstausschluss (SSoT Configs)
 ignoreIP = [
 "127.0.0.1/8" "::1"
 config.my.configs.network.lanCidr
 ];

 bantime = "1h";
 maxretry = 5;

 # 📈 INCREMENTAL BANNING (The Great Wall)
 bantime-increment = {
 enable = true;
 multipliers = "1 2 4 8 16 32 64";
 maxtime = "168h"; # Max 1 Woche
 };

 jails = {
 sshd.settings = {
 enabled = true;
 port = sshPort;
 mode = "aggressive";
 };

 # 🚨 SSH Rescue Protection (H-03)
 sshd-rescue.settings = {
 enabled = true;
 port = "2222";
 mode = "aggressive";
 maxretry = 3;
 };
 
 # 🌐 Caddy-Auth: Schützt SSO & Login-Endpunkte
 caddy-auth.settings = {
 enabled = true;
 port = "http,https";
 filter = "caddy-json";
 backend = "systemd";
 maxretry = 3;
 findtime = "5m";
 bantime = "24h";
 };

 # 🔍 Caddy-Scan: Erkennt aggressive Bot-Scanner
 caddy-scan.settings = {
 enabled = true;
 port = "http,https";
 filter = "caddy-scan";
 backend = "systemd";
 maxretry = 2;
 findtime = "1m";
 bantime = "168h";
 };
 };
 };

 # 🔍 CUSTOM FILTERS (JSON Optimized)
 environment.etc = {
 "fail2ban/filter.d/caddy-json.conf".text = ''
 [Definition]
 failregex = ^.*"remote_ip":"<ADDR>".*"status":(401|403).*$
 journalmatch = _SYSTEMD_UNIT=caddy.service
 '';
 "fail2ban/filter.d/caddy-scan.conf".text = ''
 [Definition]
 # Erweitert um gefährliche Bot-Muster (.env, .php, .config)
 failregex = ^.*"remote_ip":"<ADDR>".*"uri":".*(?:\.env|\.git|\.config|\.php|\.zip|\.gz|wp-admin|wp-login|xmlrpc)".*"status":404.*$
 journalmatch = _SYSTEMD_UNIT=caddy.service
 '';
 };

 # 🛡️ SYSTEMD SANDBOXING
 systemd.services.fail2ban.serviceConfig = {
 OOMScoreAdjust = -1000;
 ProtectSystem = "strict";
 ReadWritePaths = ["/var/lib/fail2ban" "/var/run/fail2ban"];
 PrivateTmp = true;
 };
 };
}

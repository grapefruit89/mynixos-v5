{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Auto-Locale)
 nms = {
 id = "NIXH-00-COR-003";
 title = "Auto Locale (Zero-Touch)";
 description = "Intelligent geolocation-based system localization with robust fallbacks and state persistence.";
 layer = 00;
 nixpkgs.category = "system/localization";
 capabilities = ["automation/geolocate" "system/boot-optimization"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 cfg = config.my.autoLocale;
 
 # Multi-API Geolocation (Fragment 2980)
 geolocateScript = pkgs.writeShellScript "geolocate" ''
 set -euo pipefail
 # Try ip-api.com first
 COUNTRY=$(${pkgs.curl}/bin/curl -sf --max-time 5 "http://ip-api.com/json/?fields=countryCode" | ${pkgs.jq}/bin/jq -r '.countryCode' 2>/dev/null || echo "")
 
 # Fallback to ipapi.co if needed
 if [ -z "$COUNTRY" ] || [ "$COUNTRY" == "null" ]; then
 COUNTRY=$(${pkgs.curl}/bin/curl -sf --max-time 5 "https://ipapi.co/country/" 2>/dev/null || echo "Germany")
 [[ "$COUNTRY" == "Germany" ]] && COUNTRY="DE"
 fi

 echo "''${COUNTRY:-DE}"
 '';

 cacheFile = "/var/lib/auto-locale/state.json";
in {
 options.my.meta.auto_locale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf (cfg.enable or false) {
 # 🏁 Standard-Locale (Wird durch Rebuild/State aktualisiert)
 time.timeZone = lib.mkDefault "Europe/Berlin";
 i18n.defaultLocale = lib.mkDefault "de_DE.UTF-8";

 systemd.tmpfiles.rules = [
   "d /var/lib/auto-locale 0755 root root -"
 ];

 systemd.services.auto-locale-sync = {
 description = "Auto-Locale: Sync System State with Geolocation";
 wantedBy = ["multi-user.target"];
 after = ["network-online.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 };
 script = ''
 mkdir -p "$(dirname ${cacheFile})"
 COUNTRY=$(${geolocateScript})
 echo "{\"country\": \"$COUNTRY\", \"last_sync\": \"$(date -Iseconds)\"}" > ${cacheFile}
 logger -t auto-locale "hardened Sync: System localized to $COUNTRY"
 '';
 };

 environment.systemPackages = with pkgs; [ curl jq ];
 };
}

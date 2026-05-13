# modules/security/security-stats.nix
{ pkgs, lib, config, ... }:

let
  statsFile = "/var/lib/geoip/stats.json";
  
  statsScript = pkgs.writeShellScript "collect-security-stats" ''
    set -euo pipefail
    
    # Helper to count elements in nftables sets
    count_elements() {
      local set_name=$1
      ${pkgs.nftables}/bin/nft list set inet filter "$set_name" 2>/dev/null | grep -c "elements =" || echo "0"
    }

    # Count total dropped packets from specific chains/rules if they have counters
    # (Assuming we added counters to our rules)
    
    GEO_COUNT=$(count_elements "geo_allowed")
    DC_COUNT=$(count_elements "dc_blocked")
    TOR_COUNT=$(count_elements "tor_exit_nodes")

    TIMESTAMP=$(${pkgs.coreutils}/bin/date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Generate JSON
    cat <<EOF > ${statsFile}.tmp
    {
      "last_updated": "$TIMESTAMP",
      "sets": {
        "geo_allowed": $GEO_COUNT,
        "dc_blocked": $DC_COUNT,
        "tor_exit_nodes": $TOR_COUNT
      }
    }
    EOF
    
    mv ${statsFile}.tmp ${statsFile}
    echo "Security stats updated at $TIMESTAMP"
  '';

in {
  config = lib.mkIf config.my.security.firewall.enable {
    
    systemd.services.collect-security-stats = {
      description = "Collect nftables and security metrics";
      startAt = "hourly";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = statsScript;
        # Hardening
        ProtectSystem = "strict";
        ReadWritePaths = [ "/var/lib/geoip" ];
      };
    };

    # Ensure the directory exists (it should from geoip-update.nix, but redundancy is safe)
    systemd.tmpfiles.rules = [
      "d /var/lib/geoip 0750 root root -"
    ];
  };
}

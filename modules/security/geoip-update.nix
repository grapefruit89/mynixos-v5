# modules/security/geoip-update.nix
{ pkgs, lib, config, ... }:

let
  cfg = config.my.security.firewall;
  
  # URLs for aggregated country zones (IPv4)
  # Examples: de, at, ch, lt
  mkCountryUrlV4 = cc: "https://www.ipdeny.com/ipblocks/data/aggregated/${cc}-aggregated.zone";
  mkCountryUrlV6 = cc: "https://www.ipdeny.com/ipv6/ipaddresses/blocks/${cc}.zone";

  # Datacenter / Hosting Blocklist (FireHOL Level 1 + Level 2 as a robust baseline)
  dcSources = [
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset"
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset"
  ];

  geoipDir = "/var/lib/geoip";

  # Minimal Static Seed for Cold Boot (DE/AT/LT essential ranges)
  # Truncated version of previous seed for maintainability
  staticSeedV4 = [
    "127.0.0.1/32"
    "10.0.0.0/8"
    "172.16.0.0/12"
    "192.168.0.0/16"
    "2.24.0.0/15" # DE
    "5.20.0.0/16" # LT
    "62.77.152.0/21" # AT
  ];

  staticSeedV6 = [
    "::1/128"
    "fe80::/10"
  ];

  updateScript = pkgs.writeShellScript "update-geoip-data" ''
    set -euo pipefail
    
    WORKDIR=$(mktemp -d)
    trap 'rm -rf "$WORKDIR"' EXIT

    GEO_V4="$WORKDIR/geo_v4.txt"
    GEO_V6="$WORKDIR/geo_v6.txt"
    DC_BLOCK="$WORKDIR/dc_block.txt"
    
    touch "$GEO_V4" "$GEO_V6" "$DC_BLOCK"

    # 1. Fetch GeoIP (IPv4)
    for cc in ${lib.concatStringsSep " " cfg.allowedCountries}; do
      echo "Fetching GeoIP v4 for $cc..."
      ${pkgs.curl}/bin/curl -sSfL "https://www.ipdeny.com/ipblocks/data/aggregated/$cc-aggregated.zone" >> "$GEO_V4" || echo "Warning: Failed to fetch v4 for $cc"
    done

    # 2. Fetch GeoIP (IPv6)
    for cc in ${lib.concatStringsSep " " cfg.allowedCountries}; do
      echo "Fetching GeoIP v6 for $cc..."
      ${pkgs.curl}/bin/curl -sSfL "https://www.ipdeny.com/ipv6/ipaddresses/blocks/$cc.zone" >> "$GEO_V6" || echo "Warning: Failed to fetch v6 for $cc"
    done

    # 3. Fetch Datacenter Blocklists
    for url in ${lib.concatStringsSep " " dcSources}; do
      echo "Fetching DC blocklist from $url..."
      ${pkgs.curl}/bin/curl -sSfL "$url" | grep -v "^#" >> "$DC_BLOCK" || echo "Warning: Failed to fetch DC list from $url"
    done

    # 4. Post-processing & Validation
    # Remove duplicates, empty lines, and sort
    sort -u "$GEO_V4" -o "$GEO_V4"
    sort -u "$GEO_V6" -o "$GEO_V6"
    sort -u "$DC_BLOCK" -o "$DC_BLOCK"

    # Validation: Ensure we didn't get a completely empty list for Geo
    if [ ! -s "$GEO_V4" ]; then
      echo "Error: GeoIP v4 list is empty. Aborting update."
      ${lib.optionalString (config.my.logging.vector.ntfyTopic != null) ''
        ${pkgs.curl}/bin/curl -d "GeoIP Update Failed: V4 list empty" https://ntfy.sh/${config.my.logging.vector.ntfyTopic}
      ''}
      exit 1
    fi

    # 5. Atomic Update to live filesystem
    mkdir -p ${geoipDir}
    cp "$GEO_V4" "${geoipDir}/geo_allowed_v4.zone"
    cp "$GEO_V6" "${geoipDir}/geo_allowed_v6.zone"
    cp "$DC_BLOCK" "${geoipDir}/dc_blocked.zone"

    # 6. Apply to nftables
    NFT_FILE="$WORKDIR/apply.nft"
    {
      echo "table inet filter {"
      
      echo "  set geo_allowed {"
      echo "    type ipv4_addr; flags interval;"
      echo "    elements = { $(tr '\n' ',' < "$GEO_V4" | sed 's/,$//') }"
      echo "  }"
      
      echo "  set geo_allowed_v6 {"
      echo "    type ipv6_addr; flags interval;"
      echo "    elements = { $(tr '\n' ',' < "$GEO_V6" | sed 's/,$//') }"
      echo "  }"

      echo "  set dc_blocked {"
      echo "    type ipv4_addr; flags interval;"
      echo "    elements = { $(grep -v ":" "$DC_BLOCK" | tr '\n' ',' | sed 's/,$//') }"
      echo "  }"

      echo "  set dc_blocked_v6 {"
      echo "    type ipv6_addr; flags interval;"
      echo "    elements = { $(grep ":" "$DC_BLOCK" | tr '\n' ',' | sed 's/,$//' | sed 's/^,//') }"
      echo "  }"
      
      echo "}"
    } > "$NFT_FILE"

    if ${pkgs.nftables}/bin/nft -f "$NFT_FILE"; then
      echo "✅ nftables sets updated successfully."
    else
      echo "❌ Failed to apply nftables update."
      ${lib.optionalString (config.my.logging.vector.ntfyTopic != null) ''
        ${pkgs.curl}/bin/curl -d "nftables update failed: malformed ruleset" https://ntfy.sh/${config.my.logging.vector.ntfyTopic}
      ''}
      exit 1
    fi
  '';

in {
  config = lib.mkIf cfg.enable {
    
    # 🔄 SYSTEMD UPDATE SERVICE
    systemd.services.geoip-update = {
      description = "Update nftables GeoIP and Datacenter sets";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      startAt = "weekly"; # Sonntag 03:00 (default)
      path = with pkgs; [ curl nftables gawk sed coreutils gnugrep ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = updateScript;
        # Hardening
        ProtectSystem = "strict";
        ReadWritePaths = [ geoipDir ];
        PrivateTmp = true;
        NoNewPrivileges = true;
      };
    };

    # 🏗️ TMPFILES for persistence directory
    systemd.tmpfiles.rules = [
      "d ${geoipDir} 0750 root root -"
    ];
  };
}

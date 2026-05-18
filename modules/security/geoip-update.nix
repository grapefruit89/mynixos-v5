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
    TOR_V4="$WORKDIR/tor_v4.txt"
    TOR_V6="$WORKDIR/tor_v6.txt"
    
    touch "$GEO_V4" "$GEO_V6" "$DC_BLOCK" "$TOR_V4" "$TOR_V6"

    # 1. Fetch GeoIP (IPv4)
    # ... (existing fetch logic) ...
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

    # 4. Fetch Tor Exit Nodes
    echo "Fetching Tor exit nodes (Dual-Stack)..."
    TOR_DATA=$(${pkgs.curl}/bin/curl -sSfL "https://check.torproject.org/exit-addresses")
    echo "$TOR_DATA" | ${pkgs.gnugrep}/bin/grep "ExitAddress" | ${pkgs.gawk}/bin/awk '{print $2}' | ${pkgs.gnugrep}/bin/grep -v ":" > "$TOR_V4" || true
    echo "$TOR_DATA" | ${pkgs.gnugrep}/bin/grep "ExitAddress" | ${pkgs.gawk}/bin/awk '{print $2}' | ${pkgs.gnugrep}/bin/grep ":" > "$TOR_V6" || true

    # 5. Post-processing & Validation
    sort -u "$GEO_V4" -o "$GEO_V4"
    sort -u "$GEO_V6" -o "$GEO_V6"
    sort -u "$DC_BLOCK" -o "$DC_BLOCK"
    sort -u "$TOR_V4" -o "$TOR_V4"
    sort -u "$TOR_V6" -o "$TOR_V6"

    # Validation: Ensure we didn't get a completely empty list for Geo
    if [ ! -s "$GEO_V4" ]; then
      echo "Error: GeoIP v4 list is empty. Aborting update."
      ${lib.optionalString (config.my.logging.vector.ntfyTopic != null) ''
        ${pkgs.curl}/bin/curl -d "GeoIP Update Failed: V4 list empty" ${config.my.configs.identity.ntfyUrl}/${config.my.logging.vector.ntfyTopic}
      ''}
      exit 1
    fi

    # 6. Atomic Update to live filesystem
    mkdir -p ${geoipDir}
    cp "$GEO_V4" "${geoipDir}/geo_allowed_v4.zone"
    cp "$GEO_V6" "${geoipDir}/geo_allowed_v6.zone"
    cp "$DC_BLOCK" "${geoipDir}/dc_blocked.zone"
    cp "$TOR_V4" "${geoipDir}/tor_exit_v4.zone"
    cp "$TOR_V6" "${geoipDir}/tor_exit_v6.zone"

    # 7. Apply to nftables
    NFT_FILE="$WORKDIR/apply.nft"
    {
      echo "table inet filter {"
      
      echo "  set geo_allowed {"
      echo "    type ipv4_addr; flags interval;"
      GEO_V4_ELEMS=$(${pkgs.coreutils}/bin/tr '\n' ',' < "$GEO_V4" | ${pkgs.gnused}/bin/sed 's/,$//' || true)
      [ -n "$GEO_V4_ELEMS" ] && echo "    elements = { $GEO_V4_ELEMS }"
      echo "  }"
      
      echo "  set geo_allowed_v6 {"
      echo "    type ipv6_addr; flags interval;"
      GEO_V6_ELEMS=$(${pkgs.coreutils}/bin/tr '\n' ',' < "$GEO_V6" | ${pkgs.gnused}/bin/sed 's/,$//' || true)
      [ -n "$GEO_V6_ELEMS" ] && echo "    elements = { $GEO_V6_ELEMS }"
      echo "  }"

      echo "  set dc_blocked {"
      echo "    type ipv4_addr; flags interval;"
      DC_V4_ELEMS=$(${pkgs.gnugrep}/bin/grep -v ":" "$DC_BLOCK" | ${pkgs.coreutils}/bin/tr '\n' ',' | ${pkgs.gnused}/bin/sed 's/,$//' || true)
      [ -n "$DC_V4_ELEMS" ] && echo "    elements = { $DC_V4_ELEMS }"
      echo "  }"

      echo "  set dc_blocked_v6 {"
      echo "    type ipv6_addr; flags interval;"
      DC_V6_ELEMS=$(${pkgs.gnugrep}/bin/grep ":" "$DC_BLOCK" | ${pkgs.coreutils}/bin/tr '\n' ',' | ${pkgs.gnused}/bin/sed 's/,$//' | ${pkgs.gnused}/bin/sed 's/^,//' || true)
      [ -n "$DC_V6_ELEMS" ] && echo "    elements = { $DC_V6_ELEMS }"
      echo "  }"

      echo "  set tor_exit_nodes {"
      echo "    type ipv4_addr; flags interval;"
      TOR_V4_ELEMS=$(${pkgs.gnugrep}/bin/grep -v ":" "$TOR_V4" | ${pkgs.coreutils}/bin/tr '\n' ',' | ${pkgs.gnused}/bin/sed 's/,$//' || true)
      [ -n "$TOR_V4_ELEMS" ] && echo "    elements = { $TOR_V4_ELEMS }"
      echo "  }"

      echo "  set tor_exit_nodes_v6 {"
      echo "    type ipv6_addr; flags interval;"
      TOR_V6_ELEMS=$(${pkgs.gnugrep}/bin/grep ":" "$TOR_V6" | ${pkgs.coreutils}/bin/tr '\n' ',' | ${pkgs.gnused}/bin/sed 's/,$//' || true)
      [ -n "$TOR_V6_ELEMS" ] && echo "    elements = { $TOR_V6_ELEMS }"
      echo "  }"
      
      echo "}"
    } > "$NFT_FILE"

    if ${pkgs.nftables}/bin/nft -f "$NFT_FILE"; then
      echo "✅ nftables sets updated successfully."
    else
      echo "❌ Failed to apply nftables update."
      ${lib.optionalString (config.my.logging.vector.ntfyTopic != null) ''
        ${pkgs.curl}/bin/curl -d "nftables update failed: malformed ruleset" ${config.my.configs.identity.ntfyUrl}/${config.my.logging.vector.ntfyTopic}
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
      startAt = "daily"; # Täglich (was weekly)
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

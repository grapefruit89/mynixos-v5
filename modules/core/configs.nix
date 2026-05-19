{ lib, myLib, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-001";
    title = "Global System Configs";
    description = "Single Source of Truth for global configuration values, domain settings, and hardware detection.";
    layer = 0;
    nixpkgs.category = "core/config";
    capabilities = ["core/ssot" "system/identity" "storage/tiering"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 2;
  };
in
{
  options.my.meta.configs = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

  # 🚀 Single Source of Truth für globale Konfigurationswerte
  # Nutzt Traceability Matrix v2 (ADR 220)
  options.my.configs = {
    identity = {
      sshKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of authorized SSH public keys for the primary user.";
      };
      domain = myLib.mkTracedOption "SRC-OBS-220" (lib.mkOption { 
        type = lib.types.str; 
        default = "m7c5.de"; 
        description = "Global base domain (Production Hardened)";
      });
      subdomain = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption { 
        type = lib.types.str; 
        default = "nix"; 
        description = "NixOS specific subdomain";
      });
      user = myLib.mkTracedOption "SRC-CHAT-748" (lib.mkOption {
        type = lib.types.str;
        default = "moritz";
        description = "Primary system administrator user";
      });
      email = lib.mkOption {
        type = lib.types.str;
        default = "git@m7c5.de";
        description = "Global administrator email";
      };
      ntfyUrl = lib.mkOption {
        type = lib.types.str;
        default = "https://ntfy.nix.m7c5.de";
        description = "Local ntfy-sh server URL";
      };
      host = lib.mkOption {
        type = lib.types.str;
        default = "nixhome";
        description = "The target hostname";
      };
    };
    
    network = {
      lanIP = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption { 
        type = lib.types.str; 
        default = "192.168.2.73"; 
        description = "Primary LAN IP of the target host";
      });
      lanCidr = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
        type = lib.types.str;
        default = "192.168.2.0/24";
        description = "Trusted local network range";
      });
      lanCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "192.168.2.0/24" ];
        description = "List of trusted LAN ranges";
      });
      privateRanges = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "127.0.0.0/8" "10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16" ];
        description = "RFC1918 Private IP Ranges";
      };
      lanCidrV6 = myLib.mkTracedOption "SRC-SPEC-FIREWALL" (lib.mkOption {
        type = lib.types.str;
        default = "fc00::/7";
        description = "Trusted local IPv6 range (ULA)";
      });
      linkLocalV6 = lib.mkOption {
        type = lib.types.str;
        default = "fe80::/10";
        description = "IPv6 Link-Local range";
      };
      adminVpnIPs = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "10.100.0.1/32" "fdc9:100::1/128" ];
        description = "Admin WireGuard VPN Interface IPs";
      };
      globalAllowedV6 = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of globally trusted IPv6 ranges (Production Hardened)";
      };
    };

 locale = {
 default = lib.mkOption { type = lib.types.str; default = "de_DE.UTF-8"; };
 timezone = lib.mkOption { type = lib.types.str; default = "Europe/Berlin"; };
 };

    hardware = {
      profile = lib.mkOption {
        type = lib.types.enum [ "generic" "q958" "vm" ];
        default = let
          productName = if builtins.pathExists "/sys/class/dmi/id/product_name" 
                        then lib.trim (builtins.readFile "/sys/class/dmi/id/product_name") 
                        else "generic";
        in if productName == "ESPRIMO Q958" then "q958" else "generic";
        description = "Hardware-specific optimization profile (Auto-detected via DMI)";
      };
      ramGB = myLib.mkTracedOption "SRC-CHAT-160" (lib.mkOption {
        type = lib.types.int;
        default = 16;
        description = "Physical RAM in GB (for ZRAM tuning)";
      });
      intelGpu = lib.mkOption { type = lib.types.bool; default = true; };
      cpuType = lib.mkOption { type = lib.types.str; default = "intel"; };
    };

    # 💾 ABC-TIERING STORAGE PATHS (ADR 852 / v6.1 Strict Spec)
    # Tier A: NVMe (Databases, OS, High-IOPS)
    # Tier B: SSD (Cache B1, Private B2, Buffer B3)
    # Tier C: HDD (Archive - Exclusive for cold downloads/media overflow)
    paths = rec {
      tierA = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/persist"; description = "NVMe: Persistent State"; });
      tierB = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/cache"; description = "SSD: Fast Storage (B1/B2/B3)"; });
      tierC = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; description = "HDD: Cold Archive (Exclusive)"; });

      # Derived Paths (SSoT)
      stateDir = "${tierA}/var/lib";
      appData = "${tierA}/app-data"; # Tier A: Databases, Configs
      
      # Tier B Categorization
      appCache = "${tierB}/cache";   # B1: Volatile Cache
      privateData = "${tierB}/private"; # B2: Photos, Documents, Active Media
      downloads = "${tierB}/buffer"; # B3: Active SABnzbd / Downloads
      logDir = "${tierB}/logs";      # SSD Log Tier

      # Legacy / High-Level Mappings
      mediaLibrary = "${privateData}/media";
      # Tier C: Cold archive for overflow B2 media files
      mediaArchive = "${tierC}/archive/media";
      storagePool = tierC;
    };

 # 🚩 SAFETY TOGGLES
 bastelmodus = lib.mkOption {
 type = lib.types.bool;
 default = false;
 description = "If true, disables some security assertions for easier debugging.";
 };
 
 vpn = {
 privado = {
   publicKey = lib.mkOption { type = lib.types.str; default = "KgTUh3KLijVluDvNpzDCJJfrJ7EyLzYLmdHCksG4sRg="; };
   endpoint = lib.mkOption { type = lib.types.str; default = "91.148.237.38:51820"; };
   address = lib.mkOption { type = lib.types.str; default = "100.64.3.155/32"; };
   dns = lib.mkOption { type = lib.types.listOf lib.types.str; default = ["198.18.0.1" "198.18.0.2"]; };
 };
 };

    zones = {
      admin = lib.mkOption { type = lib.types.str; default = "admin-hangar"; };
      public = lib.mkOption { type = lib.types.str; default = "public"; };
      family = lib.mkOption { type = lib.types.str; default = "family-pocketid"; };
      loopback = lib.mkOption { type = lib.types.str; default = "loopback"; };
    };

    systemd = {
      restartSec = lib.mkOption { type = lib.types.str; default = "5s"; };
    };

 resourceLimits = {
 maxMediaRamMB = lib.mkOption { type = lib.types.int; default = 4096; };
 };
 };

 options.my.storage = {
  devices = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "/dev/sda" "/dev/sdb" ];
    description = "List of physical HDD device paths for power state monitoring.";
  };

  config = {
    warnings = lib.optional (!(config.my.configs.bastelmodus || config.my.configs.hardware.profile != "generic"))
      "Production Hardened Safety: No hardware profile detected or set. Auto-detection for Q958 failed and no manual profile was specified. Set my.configs.hardware.profile to 'q958' or 'vm'.";
  };
}

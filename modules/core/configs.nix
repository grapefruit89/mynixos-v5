{ lib, myLib, ... }: {
  # 🚀 Single Source of Truth für globale Konfigurationswerte
  # Nutzt Traceability Matrix v2 (ADR 220)
  options.my.configs = {
    identity = {
      domain = myLib.mkTracedOption "SRC-OBS-220" (lib.mkOption { 
        type = lib.types.str; 
        default = "m7c5.de"; 
        description = "Global base domain (Aviation-Grade)";
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
      tailnetCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "100.64.0.0/10" ];
        description = "Tailscale network range";
      });
    };

    locale = {
      default = lib.mkOption { type = lib.types.str; default = "de_DE.UTF-8"; };
      timezone = lib.mkOption { type = lib.types.str; default = "Europe/Berlin"; };
    };

    hardware = {
      profile = lib.mkOption {
        type = lib.types.str;
        default = "q958";
        description = "The target hardware profile.";
      };
      ramGB = myLib.mkTracedOption "SRC-CHAT-160" (lib.mkOption {
        type = lib.types.int;
        default = 16;
        description = "Physical RAM in GB (for ZRAM tuning)";
      });
      intelGpu = lib.mkOption { type = lib.types.bool; default = true; };
      cpuType = lib.mkOption { type = lib.types.str; default = "intel"; };
    };

    # 💾 ABC-TIERING STORAGE PATHS (ADR 852 / Fragment 1035)
    paths = {
      stateDir = lib.mkOption { type = lib.types.str; default = "/var/lib"; };
      tierA = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/persist"; description = "NVMe: Persistent State"; });
      tierB = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/cache"; description = "SSD: Cache & Transcodes"; });
      tierC = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; description = "HDD: Bulk Media Archive"; });
      
      appData = lib.mkOption { type = lib.types.str; default = "/persist/app-data"; description = "Tier A: High-IOPS (Databases, Configs)"; };
      appCache = lib.mkOption { type = lib.types.str; default = "/mnt/cache/app-cache"; description = "Tier B: High-Volume (Images, Transcodes)"; };
      downloads = lib.mkOption { type = lib.types.str; default = "/mnt/cache/downloads"; description = "Tier B: High-Write (Active SABnzbd)"; };
      
      mediaLibrary = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool/media"; };
      storagePool = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; };
    };

    # 🚩 SAFETY TOGGLES
    bastelmodus = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "If true, disables some security assertions for easier debugging.";
    };
    
    vpn = {
      privado = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Privado VPN configuration (placeholder)";
      };
    };

    resourceLimits = {
      maxMediaRamMB = lib.mkOption { type = lib.types.int; default = 4096; };
    };
  };
}

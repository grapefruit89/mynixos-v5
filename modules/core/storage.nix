# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-AUTO-GEN",
#   "title": "Auto Generated",
#   "layer": 99,
#   "category": "auto/gen",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 2,
#   "tags": ["auto-generated"],
#   "description": "Auto-migrated module to NIXMETA 2.0."
# }
# ---ENDNIXMETA

{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-040";
    title = "Unified Storage Pool (MergerFS)";
    description = "Unified storage pool using MergerFS with HDD silence protocol and tiered caching.";
    layer = 0;
    nixpkgs.category = "core/storage";
    capabilities = ["storage/mergerfs" "storage/tiering" "storage/performance"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 3;
  };

  cfg = config.my.media.storagePool;
  # Pfade aus SSoT Registry
  srePaths = config.my.configs.paths;
in
{
  options.my.meta.storage = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

  options.my.media.storagePool = {
    enable = lib.mkEnableOption "Unified MergerFS Storage Pool";
  };

  config = lib.mkIf cfg.enable {
    # 🏎️ MergerFS Mounts (anchor: mergerfs-pool)
    systemd.mounts = [
      {
        description = "Unified Storage Pool (MergerFS)";
        where = "/storage";
        what = "/mnt/cache:/mnt/hdd1:/mnt/hdd2";
        type = "fuse.mergerfs";
        # Härtung: After/Requires local-fs.target stellt sicher, dass Platten da sind
        # FUSE: cache.files=partial (Review-Empfehlung) für bessere HDD-Silence
        options = "allow_other,use_ino,cache.files=partial,cache.entry=3600,cache.attr=3600,cache.readdir=true,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,noatime,x-systemd.after=local-fs.target,x-systemd.requires=local-fs.target";
        wantedBy = [ "multi-user.target" ];
      }
      {
        description = "App Data Synergy Pool (Tier A/B)";
        where = "/mnt/app-data-synergy";
        what = "${srePaths.appData}:${srePaths.tierB}/appdata";
        type = "fuse.mergerfs";
        options = "allow_other,use_ino,cache.files=off,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=app-data-synergy,noatime,x-systemd.after=local-fs.target,x-systemd.requires=local-fs.target";
        wantedBy = [ "multi-user.target" ];
      }
    ];

    # 🚀 HDD-Silence-Protocol: Inode Warmer
    systemd.services.hdd-inode-warmer = {
      description = "Refined Inode Warmer for HDD Ghost-Tree";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.findutils}/bin/find /mnt/hdd_pool -mindepth 1 -maxdepth 5 -exec stat {} +";
        # Jailing für den Warmer
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
      };
    };

    systemd.timers.hdd-inode-warmer = {
      description = "Timer for HDD Metadata Cache Warmer";
      timerConfig = {
        OnCalendar = "00/6:00:00";
        Unit = "hdd-inode-warmer.service";
      };
      wantedBy = [ "timers.target" ];
    };

    # 🛡️ Path Enforcement (Hardened Permissions)
    systemd.services.storage-init = {
      description = "Storage Path Initialization";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ProtectSystem = "strict";
        ProtectHome = true;
      };
      script = ''
        # Verzeichnisse anlegen
        mkdir -p /storage/{media,downloads,documents,backups}
        mkdir -p ${srePaths.tierB}/appdata
        # Rechte setzen (Media-Gruppe)
        chown -R root:media /storage/media /storage/downloads
        chmod -R 775 /storage/media /storage/downloads
      '';
    };

    # 💤 HDD Spindown Policy
    services.udev.extraRules = ''
      SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -S 120 /dev/%k"
    '';

    environment.systemPackages = with pkgs; [ mergerfs util-linux hdparm ];
  };
}

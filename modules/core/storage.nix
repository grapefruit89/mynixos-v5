{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Storage Basis)
  nms = {
    id = "NIXH-00-COR-035";
    title = "Storage Foundation";
    description = "Declarative storage paths and mergerfs pool definitions. Foundation for ABC-Tiering.";
    layer = 00;
    nixpkgs.category = "system/storage";
    capabilities = ["storage/mergerfs" "storage/abc-tiering"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
    source_repo = "grapefruit89/mynixos";
  };
  
  cfg = config.my.services.storagePool;
  # Pfade aus SSoT Registry
  lanIP = config.my.configs.network.lanIP;
in
{
  options.my.meta.storage = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = lib.mkIf cfg.enable {
    # 🏎️ MergerFS Mounts für den Media-Stack (Atomic Moves ready)
    systemd.mounts = [
      {
        description = "Unified Storage Pool (MergerFS)";
        where = "/storage";
        what = "/mnt/cache:/mnt/hdd1:/mnt/hdd2";
        type = "fuse.mergerfs";
        options = "allow_other,use_ino,cache.files=auto-full,cache.entry=3600,cache.attr=3600,cache.readdir=true,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,noatime";
        wantedBy = [ "multi-user.target" ];
      }
    ];

    # 🚀 HDD-Silence-Protocol: Inode Warmer
    systemd.services.hdd-inode-warmer = {
      description = "Warmer for HDD Metadata Cache";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.findutils}/bin/find /storage -maxdepth 3";
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

    # 🛡️ Path Enforcement (Aviation-Grade Permissions)
    systemd.services.storage-init = {
      description = "Storage Path Initialization";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
        # Verzeichnisse anlegen
        mkdir -p /storage/{media,downloads,documents,backups}
        # Rechte setzen (Media-Gruppe)
        chown -R root:media /storage/media /storage/downloads
        chmod -R 775 /storage/media /storage/downloads
      '';
    };

    # 💤 HDD Spindown Policy (Aviation-Grade Ghosting Prevention)
    services.udev.extraRules = ''
      SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -S 120 /dev/%k"
    '';

    environment.systemPackages = with pkgs; [ mergerfs util-linux hdparm ];
  };
}

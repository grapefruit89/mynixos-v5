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
        options = "allow_other,use_ino,cache.readdir=true,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,direct_io";
        wantedBy = [ "multi-user.target" ];
      }
    ];

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

    environment.systemPackages = with pkgs; [ mergerfs util-linux ];
  };
}

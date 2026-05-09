# ---
# nms_id: APP-MEDIA-JELLYFIN
# title: Jellyfin (hardened)
# capabilities: [ "media", "jellyfin", "gpu" ]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ lib, pkgs, config, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Jellyfin)
 # Fragment-Sourcing:
 # - NIXH-40-MED-007: Basis Jellyfin Modul
 # - Fragment 2272: i915 QuickSync GuC/HuC Aktivierung
 # - ADR 852: ABC-Tiering (State Tier A, Cache Tier B)
 nms = {
 id = "NIXH-01-APP-JEL-001";
 title = "Jellyfin (hardened)";
 description = "Hardware-accelerated media server with QuickSync and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = [ "media/jellyfin" "gpu/qsv" "security/sandboxing" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.media.jellyfin;
 srePaths = config.my.configs.paths;
 ssdMetadataDir = "${srePaths.tierB}/metadata/jellyfin";
 
 # Spezifische Kodierungs-Config (hardened Defaults)
 encodingXml = pkgs.writeText "encoding.xml" ''
 <?xml version="1.0" encoding="utf-8"?>
 <EncodingOptions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
 <EncodingThreadCount>-1</EncodingThreadCount>
 <TranscodingTempPath>${srePaths.tierB}/cache/jellyfin-transcode</TranscodingTempPath>
 <EnableHardwareAcceleration>true</EnableHardwareAcceleration>
 <HardwareAccelerationType>qsv</HardwareAccelerationType>
 </EncodingOptions>
 '';

in
{
 options.my.meta.jellyfin = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.jellyfin.enable = lib.mkEnableOption "Jellyfin Media Server";

 config = lib.mkIf cfg.enable (lib.mkMerge [
 
 # 🎬 1. hardened STREAMER FABRIK (Updated Spec)
 (myLib.mkStreamer {
 inherit config;
 name = "jellyfin";
 port = config.my.ports.jellyfin;
 useGPU = true; # 🔥 QuickSync / UHD 630 Zugriff
 memoryMax = "4G";
 cpuWeight = 80;
 description = "Jellyfin hardened Instance";
 })

 # 🔧 2. JELLYFIN SPECIFICS
 {
 services.jellyfin = {
 enable = true;
 group = "media";
 };

 # 🚀 RAM-DISK FÜR TRANSCODING (Anti-HDD-Spinup)
 systemd.mounts = [
 {
 where = "/run/jellyfin-transcode";
 what = "tmpfs";
 fsType = "tmpfs";
 options = "size=2G,mode=750,uid=jellyfin,gid=media";
 wantedBy = [ "jellyfin.service" ];
 before = [ "jellyfin.service" ];
 }
 ];

 systemd.services.jellyfin = {
 # QuickSync Treiber-Kontext (Source: Fragment 2272)
 environment = {
 OCL_ICD_VENDORS = "intel";
 LIBVA_DRIVER_NAME = "iHD"; # Force modern Intel Driver
 FFMPEG_TRANSCODING_TEMP_DIR = "/run/jellyfin-transcode";
 };

 # Automatischer Sync der SRE-Encoding-Policy
 # hardened: use -- for safety
 preStart = ''
   mkdir -p -- "${srePaths.stateDir}/jellyfin/config"
   cp -f -- "${encodingXml}" "${srePaths.stateDir}/jellyfin/config/encoding.xml"
 '';

 serviceConfig = {
 # Netzwerk-Schild (Ergänzend zur Factory)
 IPAddressAllow = [ "127.0.0.1/8" "::1/128" ] 
 ++ config.my.configs.network.lanCidrs
 ++ config.my.configs.network.tailnetCidrs;
 };
 };

 # 📁 BIND MOUNTS FÜR METADATEN (ABC-Tiering / ADR 852)
 systemd.tmpfiles.rules = [
 "d ${ssdMetadataDir} 0775 jellyfin media -"
 ];

 fileSystems."/var/lib/jellyfin/metadata" = {
 device = ssdMetadataDir;
 options = [ "bind" ];
 dependsOn = [ srePaths.tierB ];
 };
 }
 ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f4\n * eof_marker: NIXHOME_VALID_EOF* ---\n */

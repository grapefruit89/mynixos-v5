{ lib, config, ... }:
let
 # 🚀 NMS v4.0 Metadaten
 nms = {
 id = "NIXH-20-INF-008";
 title = "Vpn Live Config";
 description = "Dynamic runtime configuration for VPN credentials and endpoints.";
 layer = 10;
 nixpkgs.category = "data/networking";
 capabilities = [ "network/vpn-config" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.vpn_live_config = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for vpn-live-config module";
 };

 config = let
   p = config.my.configs.vpn.privado;
 in {
 my.configs.vpn.privado = {
   publicKey = lib.mkDefault p.publicKey;
   endpoint = lib.mkDefault p.endpoint;
   address = lib.mkDefault p.address;
   dns = lib.mkDefault p.dns;
 };
 };
}

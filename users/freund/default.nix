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

{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Identity)
 nms = {
 id = "NIXH-USR-FREUND-001";
 title = "User (Freund)";
 description = "Isolated user profile for collaboration. Demonstration of horizontal decoupling.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
in {
  config = {
   assertions = [{
     assertion = config.users.users.freund.openssh.authorizedKeys.keys != [];
     message = "freund: SSH key must be set in users/freund/default.nix before deployment.";
   }];

 users.users.freund = {
 isNormalUser = true;
 description = "Collaborator (Freund)";
 extraGroups = ["video" "render" "media"]; # Kein 'wheel' für den Freund
 
 # Passwort via Sops (Ausschnitt aus secrets.yaml)
 hashedPasswordFile = config.sops.secrets.freund_password.path;
 
 openssh.authorizedKeys.keys = []; # No key yet – add real key before deployment
 
 shell = pkgs.bashInteractive;
 };

 sops.secrets.freund_password.neededForUsers = true;
 };
}

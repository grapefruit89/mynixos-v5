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
 users.users.freund = {
 isNormalUser = true;
 description = "Collaborator (Freund)";
 extraGroups = ["video" "render" "media"]; # Kein 'wheel' für den Freund
 
 # Passwort via Sops (Ausschnitt aus secrets.yaml)
 hashedPasswordFile = config.sops.secrets.freund_password.path;
 
 openssh.authorizedKeys.keys = [
 "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...PLACEHOLDER..." 
 ];
 
 shell = pkgs.bashInteractive;
 };

 sops.secrets.freund_password.neededForUsers = true;
 };
}

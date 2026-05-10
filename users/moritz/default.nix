{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Identity)
 nms = {
 id = "NIXH-00-COR-039";
 title = "Users (Declarative & Hardened)";
 description = "Strictly immutable user management. Passwords managed via Sops-Nix. Unified media group.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["system/users" "security/no-mutable-users" "security/sops-integration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.users = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

  imports = [ ./locale.nix ./identity.nix ];

 config = {
 # 🚫 NO IMPERATIVE CHANGES ALLOWED
 users.mutableUsers = false;

    users.users.${user} = {
      isNormalUser = true;
      description = "Primary Admin (${user})";
      extraGroups = ["wheel" "video" "render" "media" "networkmanager"];
      
      # Passwort via Sops (Aviation-Grade Security)
      hashedPasswordFile = config.sops.secrets.user_password.path;
      
      openssh.authorizedKeys.keys = config.my.identity.sshKeys;
      
      shell = pkgs.bashInteractive;
    };

 # 📁 UNIFIED MEDIA GROUP (Fragment 1035 Alignment)
 # GID 998 (NixOS Standard für Media oft niedriger, wir bleiben bei 169 für SSoT)
 users.groups.media = {
 gid = 169;
 };

 # Sops Secret Definition
 sops.secrets.user_password.neededForUsers = true;
 };
}

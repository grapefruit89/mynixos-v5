{ config, lib, pkgs, ... }: {
 # 🚀 hardened MISSION PROFILE: SECURITY HARDENED
 # Bündelt alle Security-Assertions und Härtungs-Maßnahmen.

 imports = [
 ../modules/security/security-assertions.nix
 ../modules/security/binary-only.nix
 ../modules/security/no-legacy.nix
 ../modules/security/flat-layout.nix
 ../modules/security/hardened-core.nix
 ];

 # Standard-Metadaten für das Profil
 my.meta.profile_security = {
 id = "NIXH-PROF-SEC-001";
 title = "Security Hardened Profile";
 layer = 90;
 audit.last_reviewed = "2026-04-27";
 };

 # 🛡️ hardened Core (Task 2 / Core Hardening Plan)
 my.security.hardened = {
 enable = true;
 lockdownMode = "permissive"; # Safety first: Log violations, don't kill yet.
 };
}

{ config, lib, ... }: {
 # 💾 hardened IMPERMANENCE (ADR 852)
 # Verwaltet die systemweiten Persistenz-Pfade für das Stateless-Root (tmpfs).
 # App-spezifische Pfade werden automatisch via mkService (lib-helpers) registriert.

 config = {
 # 🛡️ SYSTEM PERSISTENCE (Tier A: NVMe State)
 environment.persistence."/persist" = {
 hideMounts = true;
 directories = [
 "/var/log"
 "/var/lib/nixos"
 "/var/lib/systemd"
 "/var/lib/sops-nix"
 "/var/lib/bluetooth"
 "/etc/NetworkManager/system-connections"
 ];
 files = [
 "/etc/machine-id"
 "/etc/ssh/ssh_host_ed25519_key"
 "/etc/ssh/ssh_host_ed25519_key.pub"
 "/etc/ssh/ssh_host_rsa_key"
 "/etc/ssh/ssh_host_rsa_key.pub"
 ];
 };

 # 🚀 ROOT-ON-RAM SETUP (Stateless Manifesto)
 fileSystems."/" = lib.mkForce {
 device = "none";
 fsType = "tmpfs";
 options = [ "defaults" "size=4G" "mode=755" ];
 };

 # 🚩 SAFETY: Kein Swap auf tmpfs erlaubt
 swapDevices = [];

 # Metadaten für die Traceability
 my.meta.impermanence = {
 id = "NIXH-00-COR-IMP";
 title = "Impermanence Core";
 description = "System-wide persistence for stateless root-on-RAM setup.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
 };
}

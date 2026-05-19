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

{ lib, ... }: {
  # 🔑 USER IDENTITY - SSoT
  # This file contains ONLY personal data (SSH keys, etc.)
  # It is designed to be easily swappable for different users.

  config.my.configs.identity = {
    sshKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvttE1EzwLJpzFc/LuuXZP485Ma0mEJQiu3iMXaO58W" # 🔑 Bitwarden-managed Key
      # TODO-016: Aktivieren, sobald TPM/YubiKey-Provisioning abgeschlossen ist
      # "sk-ssh-ed25519@openssh.com AAA..." # 🛡️ Future TPM-bound Identity
    ];
  };
}

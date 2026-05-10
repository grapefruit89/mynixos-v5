{ lib, ... }: {
  # 🔑 USER IDENTITY - SSoT
  # This file contains ONLY personal data (SSH keys, etc.)
  # It is designed to be easily swappable for different users.

  config.my.identity = {
    sshKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvttE1EzwLJpzFc/LuuXZP485Ma0mEJQiu3iMXaO58W" # 🔑 Bitwarden-managed Key
      # "sk-ssh-ed25519@openssh.com AAA..." # 🛡️ Future TPM-bound Identity
    ];
  };
}

{ config, lib, myLib, ... }:
# 🌲 DENDRITIC RESOLVER (v7.0 Strict)
# Automatically discovers and imports all NixOS modules in this directory tree.
# Uses the file system as the source of truth for modular responsibility.

let
  # 🔍 Discover all .nix files in this directory (excluding this default.nix)
  allModules = myLib.recursiveImportDir ./.;
in
{
  imports = allModules;
}

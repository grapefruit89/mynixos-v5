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

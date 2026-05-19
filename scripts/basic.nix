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

{ lib, config, ... }: {
  imports = [ ../configuration.nix ];
  assertions = [
    { assertion = config.networking.hostName != ""; message = "Hostname must be set."; }
    { assertion = config.networking.nftables.enable; message = "nftables must be enabled."; }
  ];
}

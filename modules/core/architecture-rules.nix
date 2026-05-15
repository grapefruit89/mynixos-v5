# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-COR-RUL-001",
#   "title": "Architecture Rules Enforcement",
#   "layer": 0,
#   "category": "core/policy",
#   "lastReviewed": "2026-05-15",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 2,
#   "tags": ["policy", "architecture", "hardening"],
#   "description": "Code-level enforcement of the NixHome Architecture Codex."
# }
# ---ENDNIXMETA

{ config, lib, ... }:

let
  # List of technologies that are explicitly rejected
  # We check for their corresponding NixOS options
  forbiddenEnforcement = [
    {
      assertion = !(config.virtualisation.docker.enable or false);
      message = "Architecture Violation: Docker is forbidden. Use native systemd services.";
    }
    {
      assertion = !(config.services.tailscale.enable or false);
      message = "Architecture Violation: Tailscale is forbidden. Use WireGuard.";
    }
    {
      assertion = !(config.services.nextcloud.enable or false);
      message = "Architecture Violation: Nextcloud is forbidden. Use specialized apps.";
    }
    {
      assertion = !(config.services.prometheus.enable or false);
      message = "Architecture Violation: Prometheus is forbidden. Use Gatus/Vector.";
    }
    {
      assertion = !(config.boot.zfs.enabled or false);
      message = "Architecture Violation: ZFS is incompatible with the tmpfs-root strategy.";
    }
  ];

in
{
  config = {
    # 🛡️ HARD ARCHITECTURE ASSERTIONS
    assertions = forbiddenEnforcement;

    # 📜 DYNAMIC ARCHITECTURE WARNINGS
    # Inform users where to find the formal codex
    warnings = [
      "🏛️ Architecture Codex active. See docs/adr/DOS_AND_DONTS.md for mandates."
    ];
  };
}

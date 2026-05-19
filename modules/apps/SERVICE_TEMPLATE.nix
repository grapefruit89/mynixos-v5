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

/**
 * ---
 * nms_version: 2.3
 * identity:
 * id: NIXH-60-APP-001
 * title: "SERVICE_TEMPLATE"
 * layer: 60
 * architecture:
 * req_refs: [REQ-SRV]
 * upstream: [NIXH-00-SYS-ROOT-001]
 * downstream: []
 * status: audited
 * ---
 */
{ config, lib, pkgs, ... }:

let
 domain = config.my.configs.identity.domain;
 # servicePort = config.my.ports.<service-name>;
 serviceName = "<service-name>";
in
{
 services.${serviceName} = {
 enable = true;
 };

 # ── SYSTEMD HARDENING ───────────────────────────────────────────────────
 systemd.services.${serviceName}.serviceConfig = {
 NoNewPrivileges = lib.mkForce true;
 CapabilityBoundingSet = "";
 AmbientCapabilities = "";
 UMask = "0077";
 PrivateTmp = lib.mkForce true;
 PrivateDevices = lib.mkForce true;
 ProtectHome = lib.mkForce true;
 ProtectSystem = lib.mkForce "strict";
 ProtectKernelTunables = lib.mkForce true;
 ProtectKernelModules = lib.mkForce true;
 ProtectControlGroups = lib.mkForce true;
 RestrictRealtime = lib.mkForce true;
 RestrictSUIDSGID = lib.mkForce true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
}












/**
 * ---
 * technical_integrity:
 * checksum: sha256:9bb18c572acbec0f2067f4bdc0601bda9bcff0430e0085d29890c3bf560e7fba
 * eof_marker: NIXHOME_VALID_EOF
 * audit_trail:
 * last_reviewed: 2026-02-28
 * complexity_score: 2
 * ---
 */

{ config, lib, ... }:
let
  cfg = config.my.configs;
  paths = cfg.paths;
  
  # Services allowed to touch Tier C (Exemptions)
  # v6.1 Strict Spec Enforcement
  tierCExemptions = [
    "storage-mover"
    "sabnzbd"
    "hdd-inode-warmer"
    "storage-init"
    "nixhome-emergency"
    "rotate-vector-logs"
    # Media servers: read-only access to cold archive via MergerFS
    "jellyfin"
    "navidrome"
    "audiobookshelf"
  ];

  # Helper to check if any path in a list points to Tier C
  usesTierC = pathList: lib.any (p: lib.strings.hasInfix paths.tierC (toString p)) pathList;

  # Identify unauthorized services
  unauthorizedTierCServices = lib.filterAttrs (name: svc: 
    !(lib.elem name tierCExemptions) && 
    (usesTierC (svc.serviceConfig.ReadWritePaths or []) || 
     usesTierC (svc.serviceConfig.BindPaths or []) ||
     usesTierC (svc.serviceConfig.BindReadOnlyPaths or []))
  ) config.systemd.services;

in
{
  config = {
    # 🛡️ HARDWARE VALIDATION ASSERTIONS
    # Ensure paths are mounted on the correct physical media
    assertions = [
      {
        assertion = paths.tierA == "/persist";
        message = "ABC Tiering Error: Tier A (NVMe) MUST be mounted at /persist.";
      }
      {
        assertion = paths.tierB == "/mnt/cache";
        message = "ABC Tiering Error: Tier B (SSD) MUST be mounted at /mnt/cache.";
      }
      {
        assertion = paths.tierC == "/mnt/hdd_pool";
        message = "ABC Tiering Error: Tier C (HDD) MUST be mounted at /mnt/hdd_pool.";
      }
      
      # 🛡️ GLOBAL TIER C EXCLUSION (v6.1 Strict Spec)
      # No service except the mover and sabnzbd-archive is allowed to touch Tier C.
      {
        assertion = unauthorizedTierCServices == {};
        message = "ABC Tiering Violation: Unauthorized services detected accessing Tier C (HDD): ${lib.concatStringsSep ", " (lib.attrNames unauthorizedTierCServices)}. All application data must reside on Tier B (SSD).";
      }
    ];
  };
}

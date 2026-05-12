{ config, lib, ... }:
let
  cfg = config.my.configs;
  paths = cfg.paths;
  isQ958 = cfg.hardware.profile == "q958";
in
{
  config = lib.mkIf (!cfg.bastelmodus) {
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
      
      # 🛡️ STRICT TIER C EXCLUSION
      # Only SABnzbd final destination and the storage mover are allowed to touch Tier C
      {
        assertion = !lib.strings.hasInfix paths.tierC config.services.jellyfin.dataDir;
        message = "ABC Tiering Violation: Jellyfin dataDir cannot reside on Tier C (HDD). Move to Tier B.";
      }
      {
        assertion = !lib.strings.hasInfix paths.tierC config.my.media.navidrome.musicDir;
        message = "ABC Tiering Violation: Navidrome musicDir cannot reside on Tier C (HDD). Move to Tier B.";
      }
    ];
  };
}

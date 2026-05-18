# Grok Top 10 Implementation Checklist

## GROUP 1: Hygiene & Build Safety (DO FIRST — low risk, high trust)
- [x] 1. Caddy deduplication & garbage cleanup (REPAIRED: Surgically truncated at L264; Excised rejected ddos_shield, human_challenge, rate_limit, and wake_on_demand concepts)
- [x] 8. Assertions & placeholders (REPAIRED: Collision assertions added to registry.nix/spec.nix)
- [x] 4. /nix persistence & store optimization (REPAIRED: /nix in impermanence, nix.optimise active)

## GROUP 2: Security Improvements (DO SECOND — moderate risk)
- [x] 2. Strengthen systemd sandboxing (REPAIRED: Added SystemCallFilter, RestrictNamespaces, LockPersonality, ProtectClock to mkService)
- [x] 5. Kernel hardening completeness (REPAIRED: Added userns restriction, mmap_rnd_bits=32, and AppArmor)

## GROUP 3: Observability & Performance (DO THIRD)
- [x] 6. Observability: Structured logging & Vector pipeline (REPAIRED: Created vector.nix and enabled centralized aggregator)
- [x] 7. Jellyfin/Streamer performance tuning (REPAIRED: Added Restart=always to mkStreamer and cleaned up Jellyfin serviceConfig)

## GROUP 4: Architecture & Secrets (DO LAST — highest complexity)
- [x] 10. KISS simplification of lib-helpers (REPAIRED: Refactored mkService/mkStreamer using pure helper functions)
- [x] 9. Secrets rotation & sops-nix robustness (REPAIRED: Added rotation policy and enhanced emergency sync)
- [x] 3. Media namespace nftables refinement (REPAIRED: Validated UID-based isolation for netns egress)

## CURRENT STATUS
- **Active Group:** COMPLETE
- **Status:** GROK TOP 10 FULLY IMPLEMENTED. READY FOR FINAL AUDIT.

## PHASE 3 LOG (GROUP 1)
1. **Caddy Cleanup:** Surgically removed corrupted duplicate blocks and EOF junk. Verified file ends at line 264. EXCISION: Removed rejected ddos_shield, human_challenge, and wake_on_demand snippets to match Architectural Decision I. Verified absence via grep.
2. **SSoT Assertions:** Added logic to `uid-registry.nix` and `services-spec.nix` to prevent numeric UID or port collisions during evaluation.
3. **Store Optimization:** Verified `/nix` is in `impermanence.nix`. Enabled `nix.optimise.automatic = true` in `nix-tuning.nix`.

## PHASE 4 LOG (GROUP 2)
1. **Kernel Hardening:** Added `kernel.unprivileged_userns_clone = 0` and `vm.mmap_rnd_bits = 32` to sysctls. Enabled `security.apparmor.enable = true`.
2. **Systemd Sandboxing:** Iteratively added `ProtectClock`, `LockPersonality`, `RestrictNamespaces`, and `SystemCallFilter` to the `mkService` factory. Verified syntax stability.

## PHASE 5 LOG (GROUP 3)
1. **Streamer Tuning:** Added `Restart = "always"` and `RestartSec = "5s"` to `mkStreamer` for automatic recovery. Scrubbed `service-media-jellyfin.nix` of duplicate configs and tailnet leftovers.
2. **Observability:** Created `modules/services/vector.nix` as a centralized aggregator (UID 2005). Configured journald source and JSON console sink. Enabled in `configuration.nix`.

## PHASE 6 LOG (GROUP 4)
1. **KISS Refactoring:** Refactored `lib-helpers.nix`. Extracted `mkSystemdConfig` and `mkCaddyConfig` to reduce cognitive load and improve maintainability of the factory.
2. **Secrets Robustness:** Added formal rotation policy guidance and reinforced the `sops-key-sync` service description for disaster recovery.
3. **Network Isolation:** Refined `firewall.nix` with explicit documentation and verification of the UID-based egress strategy for media namespaces.

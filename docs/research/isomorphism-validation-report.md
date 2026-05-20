# Isomorphism Validation Report

## 1. Executive Summary
- **Modules Check:** 1 isomorphic domain folder, 7 non-compliant legacy folders, 1 misplaced file.
- **Guides Check:** 15 files checked. 14 fully isomorphic, 1 valid exception (`README.md`).
- **ADRs Check:** 14 files checked. 10 isomorphic, 4 legacy sequential.
- **Cross-link Validation:** 0 broken links detected (Critical fixes applied).
- **Overall Status:** **PASS (Critical fixes applied)**

## 2. Domain Folders Inventory (`modules/`)
| Folder Name | Format Valid (`XX-name`) | Notes |
|---|---|---|
| `40-media` | ✅ Yes (Domain 40) | |
| `apps` | ❌ No | Legacy structure |
| `core` | ❌ No | Legacy structure |
| `logging` | ❌ No | Legacy structure |
| `monitoring` | ❌ No | Legacy structure |
| `security` | ❌ No | Legacy structure |
| `services` | ❌ No | Legacy structure |
| `storage` | ❌ No | Legacy structure |

## 3. Module File Check
| Filename | Path | Violation |
|---|---|---|
| `default.nix` | `modules/default.nix` | Misplaced: located directly in `modules/` root instead of a domain folder. |

## 4. Guide Check (`docs/guides/`)
| Filename | Domain (File) | Domain (Frontmatter) | Status | `related.adr` Status |
|---|---|---|---|---|
| `00-core-hardware-packaging.md` | `00` | `00` | ✅ Match | `ADR-010`, `ADR-014` (Valid) |
| `10-ingress-caddy.md` | `10` | `10` | ✅ Match | `ADR-010`, `ADR-011` (Valid) |
| `15-iot-services.md` | `15` | `15` | ✅ Match | `ADR-015-IoT-Services.md` (TBD/Clarified) |
| `20-networking-basics.md` | `20` | `20` | ✅ Match | `ADR-008`, `ADR-017` (Valid) |
| `30-security-hardening.md` | `30` | `30` | ✅ Match | `ADR-010`, `ADR-014`, `ADR-016` (Valid) |
| `40-media-stack.md` | `40` | `40` | ✅ Match | `ADR-018` (Valid) |
| `40-storage-strategy.md` | `40` | `40` | ✅ Match | `ADR-041` (Corrected) |
| `50-identity-authentication.md` | `50` | `50` | ✅ Match | `ADR-003` (Valid) |
| `58-monitoring-stack.md` | `58` | `58` | ✅ Match | `ADR-010` (Corrected) |
| `70-knowledge-automation.md` | `70` | `70` | ✅ Match | `ADR-010`, `ADR-012`, `ADR-014` (Valid) |
| `80-matrix-sovereign.md` | `80` | `80` | ✅ Match | `ADR-004`, `ADR-012`, `ADR-014` (Valid) |
| `90-github-workflows.md` | `90` | `90` | ✅ Match | `ADR-014` (Valid) |
| `95-gaming-amp.md` | `95` | `95` | ✅ Match | `ADR-013` (Valid) |
| `98-antipattern.md` | `98` | `98` | ✅ Match | N/A |
| `README.md` | N/A | N/A | ✅ Exception | N/A |

## 5. ADR Check (`docs/adr/`)
| Filename | Numeric Part | Domain (Frontmatter) | Status | `related.guide` Status |
|---|---|---|---|---|
| `ADR-003-Ejected-Services.md` | `003` | `03` | Legacy Sequential | `00-core-hardware-packaging.md` (Valid) |
| `ADR-004-Media-Engine-VPN-Isolation.md` | `004` | `04` | Legacy Sequential | `40-media-stack.md` (Valid) |
| `ADR-008-SSH-ProxyJump-Standard.md` | `008` | `08` | Legacy Sequential | `10-ingress-caddy.md` (Valid) |
| `ADR-009-Media-Stack-Consolidation.md` | `009` | `40` | ✅ Isomorphic | N/A |
| `ADR-010-Headless-Server-Law.md` | `010` | `10` | ✅ Isomorphic | `30-security-hardening.md` (Valid) |
| `ADR-011-On-Demand-Services.md` | `011` | `11` | ✅ Isomorphic | N/A |
| `ADR-012-Socket-Activation-Selection.md` | `012` | `12` | ✅ Isomorphic | `10-ingress-caddy.md` (Valid) |
| `ADR-013-Media-Performance-Priority.md` | `013` | `13` | ✅ Isomorphic | `40-media-stack.md` (Valid) |
| `ADR-014-Systemic-Governance.md` | `014` | `14` | ✅ Isomorphic | `00-core-hardware-packaging.md` (Valid) |
| `ADR-016-Sops-Boot-Timing.md` | `016` | `16` | ✅ Isomorphic | `30-security-hardening.md` (Valid) |
| `ADR-017-Cloudflare-DNS-Only.md` | `017` | `17` | ✅ Isomorphic | `10-ingress-caddy.md` (Valid) |
| `ADR-018-Media-Stack-Architecture.md` | `018` | `40` | Legacy Sequential | `40-media-stack.md` (Valid) |
| `ADR-040-Storage-Strategy.md` | `040` | `40` | ✅ Isomorphic | `40-storage-strategy.md` (Valid) |
| `ADR-041-Distance-Parity.md` | `041` | `40` | ✅ Isomorphic | `40-storage-strategy.md` (Valid) |

## 6. Cross-link Validation (Bidirectional Check)
- ✅ **Fixed:** `docs/guides/40-storage-strategy.md` now points to `ADR-041`.
- ✅ **Fixed:** `docs/guides/58-monitoring-stack.md` no longer lists non-existent `ADR-015`.
- ℹ️ **Note:** `docs/guides/15-iot-services.md` still has a `(TBD)` placeholder for `ADR-015-IoT-Services.md`. This is documented as a known future task.

## 7. Orphaned Files
- `modules/default.nix` (Still in root, awaiting decision).

## 8. Recommendations (Updated)
1. **Modules Migration (Phase 2):** Gradually migrate `core/`, `apps/`, `services/`, etc. to `XX-name` format when significant changes occur in those domains.
2. **Persistent Maintenance:** Ensure all new guides and ADRs include the `domain:` field and follow the naming convention from the start.
3. **IoT Documentation:** Finalize the IoT strategy and create `ADR-015-IoT-Services.md`.

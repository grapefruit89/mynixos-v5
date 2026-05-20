---
title: ADR-018: Media Stack Architecture (Domain 40)
status: ACCEPTED
date: 2026-05-20
domain: 40
related:
  guide: docs/guides/40-media-stack.md
  modules: modules/40-media/
---

# ADR-018: Media Stack Architecture (Domain 40)

## Context
The media stack was previously fragmented. This ADR establishes a consolidated, isomorphic structure under Domain 40.

## Decisions
1. **Consolidation**: Services are grouped into functional layers (Arr, Download, Streaming, Discovery) within `modules/40-media/`.
2. **Prowlarr-Centric**: Prowlarr is the sole indexer proxy. No direct indexers in Radarr/Sonarr.
3. **Factories**: Use `41-lib-media.nix` for consistent service hardening and impermanence registration.
4. **SceneNZBs**: Use Newznab API only. REST v1 is forbidden for Prowlarr integration.
5. **Idempotency**: Prowlarr setup uses a separate oneshot service with GET-before-POST checks and `LoadCredential`.

## Forbidden Patterns
- **AP-001**: No direct indexers in Radarr/Sonarr – exclusively through Prowlarr.
- **AP-002**: API-Keys never via `$(cat ...)` in ExecStart – only `LoadCredential`.
- **AP-003**: `EnvironmentFile` must not be used for SOPS secrets (incorrect format).
- **AP-004**: Prowlarr uses exclusively Newznab-API, not REST v1 from SceneNZBs.
- **AP-005**: Software transcoding is forbidden. Intel QuickSync / VAAPI (iGPU UHD 630) must be available for Jellyfin/ffmpeg. No CPU fallback.
- **AP-006**: The path `/dev/dri/renderD128` must physically exist and be readable. Absence is a fatal error – no automated workaround.
- **AP-007**: LUKS decryption of the system drive must be possible via initrd-SSH (Headless-Operation). No manual terminal input required.
- **AP-008**: Core kernel modules (`i915`, `nvme`, `zfs`) must be pre-loaded during boot. No runtime `modprobe` for critical drivers.
- **AP-009**: Hardware Watchdog (`iTCO_wdt`) must be active. System hangs must trigger an automatic hardware reboot without admin interaction.

## Mandatory Hardware Constraints
- **H1**: Intel iGPU (UHD 630 or comparable) with drivers `intel-media-driver` and `vaapiIntel` must be available.
- **H2**: Access to `/dev/dri/renderD128` and `/dev/dri/card0` for Jellyfin (GPU-Passthrough).
- **H3**: Kernel modules `i915`, `intel_agp` must be loaded.
- **H4**: User `jellyfin` must be in groups `render` and `video`.
- **H5**: Systemd `DeviceAllow` for `char-render` and `char-drm` must be set.
- **H6**: (Optional) `tmpfs` for `/var/cache/jellyfin` (transcode cache) must be at least 2 GB.

## Consequences
- Uniform structure and better maintainability.
- Secure handling of API keys.
- Automatic registration of impermanence paths.

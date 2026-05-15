# Design Doc: Navidrome Integration (Operation Media-Final)

## Status
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Approved (User)

## 1. Goal
Integrate Navidrome as the primary audio streaming server into the NixOS home lab environment. This completes the "Media Beast" profile by providing a dedicated music streaming solution alongside Jellyfin and Audiobookshelf.

## 2. Context & Constraints
- **Architecture:** Horizontal Responsibility (v5.0).
- **Hardening:** hardened (SSO, LAN Bypass, Systemd hardening).
- **Storage:** ABC-Tiering (Tier A for State, Tier B for Cache, Tier C for Bulk Media).
- **Patterns:** Use `myLib.mkStreamer` factory.
- **Port:** 4533 (Already registered in `ports.nix`).

## 3. Architecture Details

### 3.1 New Module: `modules/apps/service-app-navidrome.nix`
- **Options:** `my.apps.navidrome.enable`, paths (Tier A/B/C), user/group settings.
- **Factory Integration:** Calls `mkStreamer` with `useGPU = false`.
- **Hardening:** `ReadOnlyPaths` for music library, systemd sandbox (via factory).
- **Caddy:** Subdomain `music.nix.m7c5.de` aliased to the auto-generated `navidrome` host.
- **Persistence:** Mount `/var/lib/navidrome` to `/persist`.

### 3.2 Media Stack Update: `modules/apps/media-stack.nix`
- Add `navidrome` to `users.groups.media.members` to ensure consistent GID-based access to shared media folders.

### 3.3 Profile Integration: `profiles/media-beast.nix`
- Import `service-app-navidrome.nix`.
- Enable the service: `my.apps.navidrome.enable = true`.

## 4. Implementation Steps (Draft)
1. Create the Navidrome module.
2. Update `media-stack.nix` members list.
3. Update `media-beast.nix` imports and toggles.
4. Validation via `nixos-rebuild test`.

## 5. Security & Stability
- Navidrome runs as a system user.
- Network confinement: Restricted to localhost + Caddy proxy.
- File system: Restricted writes to state and cache dirs only.
- Resource limits: 1G RAM, 60 CPU weight.

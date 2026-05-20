# modules/40-media/README.md

# Domain 40 – Media Stack

This directory contains the consolidated, factory-driven media stack for NixHome v7.

## Structure

- **41-lib-media.nix**: Shared factories (`mkArr`, `mkStreamingService`) and category helpers.
- **42-arr-stack.nix**: Radarr, Sonarr, Prowlarr, Lidarr, and Readarr.
- **43-download.nix**: SABnzbd and Recyclarr.
- **44-streaming.nix**: Jellyfin, Audiobookshelf, and Navidrome.
- **45-discovery.nix**: Jellyseerr.

## Related
- **ADR:** [ADR-018-Media-Stack-Architecture.md](../../docs/adr/ADR-018-Media-Stack-Architecture.md)
- **Guide:** [docs/guides/40-media-stack.md](../../docs/guides/40-media-stack.md)

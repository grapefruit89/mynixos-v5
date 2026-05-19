# ADR-017: Cloudflare DNS-Only Mandate

## Status
Accepted

## Context
The project uses Cloudflare for DNS management and Dynamic DNS (DDNS). Cloudflare offers a proxy service ("Orange Cloud") that provides CDN, WAF, and other security features. However, the project's core functionality involves high-bandwidth media streaming (Jellyfin, Navidrome, etc.) and specific API traffic.

## Decision
We will exclusively use Cloudflare in **DNS-only mode** ("Gray Cloud"). Any form of Cloudflare proxying (Orange Cloud) is strictly prohibited.

## Rationale
1.  **Compliance (TOS)**: Cloudflare's Terms of Service (specifically Section 2.8) prohibits the use of their proxy service for non-HTML content that disproportionately consumes bandwidth, such as video and audio streaming, unless explicitly allowed via a paid plan (e.g., Stream). Violation can lead to account suspension.
2.  **Architecture Alignment**: Our hardening strategy emphasizes deep-stack hardening. Geo-blocking and rate-limiting are implemented at the kernel level (nftables), making the Cloudflare WAF redundant for our use case.
3.  **Performance**: Direct client-to-server connections avoid the overhead and latency of the Cloudflare proxy network for large media files.
4.  **Privacy**: Proxied traffic is decrypted at the Cloudflare edge. DNS-only mode ensures true End-to-End Encryption (E2EE) between the client and our Caddy instance.

## Consequences
- The `CF-IPCountry` header will not be available in Caddy.
- `trusted_proxies` in Caddy must only include local and private network ranges.
- Geo-blocking must be maintained and verified within the `firewall.nix` (nftables) configuration.
- Any attempt to enable the Cloudflare proxy for media domains is considered an Anti-Pattern.

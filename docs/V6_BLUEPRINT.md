# 🏗️ NixH-v6 Security & Automation Blueprint

## 🧱 1. Three-Zone Trust Model
| Zone | Network Reach | Authentication | Primary Use Case |
|------|---------------|----------------|------------------|
| **Loopback** | `127.0.0.1` | None | DBs, Caches, internal IPC |
| **Admin‑mTLS** | LAN/WAN | TPM-bound mTLS | Portainer, SSH, *arr suite |
| **Family‑PocketID** | LAN/WAN | PocketID Forward Auth | Nextcloud, Immich, Media |

## 🔐 2. mTLS Client Lifecycle
- **Key Gen:** Inside Laptop TPM2.0 (ECC256). Private key never leaves hardware.
- **CSR:** Generated via OpenSSL + `libtpm2_pkcs11.so`.
- **Signing:** Flask-based CA Portal (`ca.home.arpa`) signs CSR -> CRT.
- **Usage:** Browser uses PKCS#11 module to challenge Caddy.

## 🏭 3. CA Web Service (Flask)
- Bound to `127.0.0.1:5000`, served via Caddy (LAN-only).
- BasicAuth for bootstrap safety.
- Manages CA key via `sops-nix`.

## 🧩 4. Spec-Driven Config (`services-spec.nix`)
Single source of truth for:
- **nftables:** Auto-generate rules based on `zone`.
- **Caddy:** Auto-generate `virtualHosts` with appropriate auth (mTLS vs PocketID).

## 🛡️ 5. TPM-LUKS (No Secure Boot)
- Bound to PCRs `0,1,2,3,7`.
- Systemd-cryptenroll for auto-unlock.
- Recovery key in Bitwarden (TPM-bound on Pixel 9).

## 🔗 6. SOPS Recovery
- Primary: USB AGE key.
- Secondary: Bitwarden passkey copy.

## 📚 7. Knowledge Sync
- CI script exports `services-spec.nix` to `service-inventory.md` in knowledge base.

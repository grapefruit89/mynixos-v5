# 🗺️ Distiller Project Roadmap (NixHome v5.0)

## 📌 Status Quo Analysis (2026-04-29)

### ✅ Completed (Architecture & Hardening)
- **v5.0 Core:** Horizontal Responsibility Design implemented.
- **Identity:** Strict SSO (Pocket-ID) for all services, no IP-bypasses.
- **Storage:** ABC-Tiering with Smart Mover (SSD → HDD) and transactional safety.
- **Networking:** nftables Geoblock (DE/AT/LT) and 3-Stage DDoS Shield in Caddy.
- **Security:** Runtime Security Guard (stündliche Checks) active.
- **Resilience:** Sops-Fallback for Tier A failure prepared on Tier B.

### ⚠️ Gaps & Improvement Areas (Technical Debt)
- **Disaster Recovery:** Physical Emergency-Key for Sops needs to be created on USB.
- **IPv6 Parity:** Geoblock sets for IPv6 need dynamic population.
- **Bot Defense:** JS-Challenge could be upgraded to PoW (Hashcash).

---

## 🧭 Prioritized Action Plan

| Priority | Task | Complexity | Impact | Status |
| :--- | :--- | :--- | :--- | :--- |
| 🔴 **P1** | **Persistent Logs (Vector)** | Low | High | **[DONE]** |
| 🟠 **P2** | **Backup of `/persist` (Restic)** | Low | High | **[DONE]** |
| 🟡 **P3** | **Storage Tiering Mover** | Medium | Medium | **[DONE]** |
| 🟢 **P4** | **Core Hardening (Kernel/Systemd)** | Low | Medium | **[DONE]** |
| 🔵 **P5** | **Gatus / Healthchecks** | Low | Medium | **[DONE]** |
| ⚪ **P6** | **Extra Apps (Vaultwarden, etc.)** | Low | Low | **[DONE]** |
| 🟣 **P7** | **Knowledge Pipeline (Obsidian)** | High | Low | **[IN PROGRESS]** |

---

## 📋 Detailed Task Breakdown

### 🟣 Priority 7: Knowledge Pipeline (Obsidian Sync)
- **Objective:** Bridge Nix metadata to Obsidian without "cluttering".
- **Implementation:** `meta_to_obsidian.py` script active.
- **Status:** Initial Dossiers generated in `docs/obsidian_export/`.
- **Next Step:** Import to main Obsidian Vault.

### ✅ Completed: High-Intensity Hardening (The "Steroids" Update)
- [x] **nftables-Geoblock:** DE, AT, LT restricted for port 443 (Kernel-Level).
- [x] **Caddy DDoS Shield:** 3-Stage defense (Unknown, Human, Auth) with JS-Challenge.
- [x] **API Compatibility:** Exceptions for native apps (/api, /Users, /jellyfin).
- [x] **Isolation:** Closed port 80 and SSH (53844) for public WAN.
- [x] **Integrity:** `cache.files=off` in MergerFS to prevent metadata drift.

### 🧩 System Maintenance & Cleanup
- [x] **TECHNICAL_DEBT.md:** Documentation of known risks and future tasks.
- [x] **README.md:** Clean, factual project documentation created.

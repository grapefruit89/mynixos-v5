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
| 🟣 **P7** | **Knowledge Pipeline (Obsidian)** | High | Low | **[REMOVED]** |

---

## 📋 Detailed Task Breakdown

### ✅ Completed: High-Intensity Hardening (The "Audit Fixes" Update)
- [x] **External Security Audit:** Claude Senior SRE Audit completed with zero-day finding.
- [x] **nftables-Hardening:** Atomic updates, HTTPS sources, and UID-based Admin-Fortress protection.
- [x] **CA-Server Hardening:** Path traversal protection and strict CSR sanitization implemented.
- [x] **Aviation-Grade LUKS:** Hardware-bound encryption upgraded to PCR 0+1+2+3+4+9.
- [x] **Port SSoT:** Resolved all port collisions and hardcoded ports in services-spec.nix.
- [x] **Tor Blocking:** Kernel-level blocking of Tor exit nodes active.

### 🧩 System Maintenance & Cleanup
- [x] **TECHNICAL_DEBT.md:** Documentation of known risks and future tasks.
- [x] **README.md:** Clean, factual project documentation created.
port 80 and SSH (53844) for public WAN.
- [x] **Integrity:** `cache.files=off` in MergerFS to prevent metadata drift.

### 🧩 System Maintenance & Cleanup
- [x] **TECHNICAL_DEBT.md:** Documentation of known risks and future tasks.
- [x] **README.md:** Clean, factual project documentation created.

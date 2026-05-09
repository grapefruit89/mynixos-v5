# 🗺️ Distiller Project Roadmap (NixHome v5.0)

## 📌 Status Quo Analysis (2026-04-30)

### ✅ Completed (Architecture & Hardening)
- **v5.0 Core:** Horizontal Responsibility Design implemented.
- **Security Assertions:** Non-blocking warnings (Soft-Mode) implemented to avoid development friction.
- **Identity:** Strict SSO (Pocket-ID) for all services, no IP-bypasses.
- **Storage:** ABC-Tiering with Smart Mover (SSD → HDD) and transactional safety.
- **Networking:** nftables Geoblock (DE/AT/LT) and 3-Stage DDoS Shield in Caddy.
- **Security:** Runtime Security Guard (stündliche Checks) active.
- **Resilience:** Sops-Fallback for Tier A failure prepared on Tier B.
- **Apps (P6):** Linkding implemented, Vaultwarden active.

### 🚫 Excluded / Removed
- **Semaphore:** Removed from current implementation plan.
- **RAG / Knowledge Pipeline:** Permanently canceled and removed from scope.

---

## 🧭 Prioritized Action Plan

| Priority | Task | Complexity | Impact | Status |
| :--- | :--- | :--- | :--- | :--- |
| 🔴 **P1** | **Persistent Logs (Vector)** | Low | High | **[DONE]** |
| 🟠 **P2** | **Backup of `/persist` (Restic)** | Low | High | **[DONE]** |
| 🟡 **P3** | **Storage Tiering Mover** | Medium | Medium | **[DONE]** |
| 🟢 **P4** | **Core Hardening (Kernel/Systemd)** | Low | Medium | **[DONE]** |
| 🔵 **P5** | **Gatus / Healthchecks** | Low | Medium | **[DONE]** |
| ⚪ **P6** | **Extra Apps (Linkding, etc.)** | Low | Low | **[DONE]** |

---

### ✅ Completed: High-Intensity Hardening (The "Steroids" Update)
- [x] **Geo-IP Seeding:** ~1200 CIDR ranges (DE, AT, LT) pre-seeded for first-boot protection.
- [x] **CA-Server Hardening:** Deep CSR validation (OpenSSL), AF_UNIX restriction, and DDoS protection.
- [x] **Pocket-ID Integration:** Native NixOS module with Unix socket ingress.
- [x] **Forbidden Tech Policy:** Soft-Mode warnings for Docker, Tailscale, etc. (No build blockers).
- [x] **Logging Strategy:** Switched to RAM-buffered SSD chunking via Vector.
- [x] **nftables-Geoblock:** DE, AT, LT restricted for port 443 (Kernel-Level).
- [x] **Caddy DDoS Shield:** 3-Stage defense (Unknown, Human, Auth) with JS-Challenge.
- [x] **API Compatibility:** Exceptions for native apps (/api, /Users, /jellyfin).
- [x] **Isolation:** Closed port 80 and SSH (53844) for public WAN.
- [x] **Integrity:** `cache.files=off` in MergerFS to prevent metadata drift.

---

## 🛠️ Next Sortie: Residual Todo List (Current Audit Results)

### 🔴 CRITICAL (Deployment Blocker)
- [ ] **Manual Secret Population:** `secrets/secrets.yaml` befüllen (`user_password`, `freund_password`, `restic_password`, `backblaze_keys`).
- [ ] **Hardware Identity:** Configuration of **Hermetic** for TPM-bound SSH keys.

### 🟠 HIGH (Security & Reliability)
- [ ] **S3 Log Sync:** Implementation of hourly encrypted log-syncing to S3.
- [ ] **Backup Validation:** `backupPrepareCommand` in `backup.nix` um `/persist` und `/var/lib/pocket-id` erweitern.

### 🟡 MEDIUM (Optimization)
- [ ] **Gatus Hardening:** Bind-Adresse von `0.0.0.0` auf `127.0.0.1` ändern.
- [ ] **Jellyfin Config:** `encoding.xml` Management verbessern (Pre-Start Script durch stabilere Lösung ersetzen).

---

### 🧩 System Maintenance & Cleanup
- [x] **WORKSPACE_MAP.md:** Central index for faster navigation created.
- [x] **TECHNICAL_DEBT.md:** Documentation of known risks and future tasks.
- [x] **README.md:** Clean, factual project documentation created.

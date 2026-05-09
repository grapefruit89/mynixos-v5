# 🗺️ Distiller Project Roadmap (NixHome v6.0)

## 📌 Status Quo Analysis (2026-05-09)

### ✅ Completed (v6.0 Hardening & Audit)
- **v6.0 Transition:** Modular entrypoint with horizontal responsibility decoupling hardware, users, and apps.
- **Foundational Audit:** System, Network, and Locale modules consolidated and bugfixed (networkd options verified).
- **Security Audit:** nftables syntax fixed (first-boot seed), SSH hardened (Post-Quantum), and fail2ban integrated with Caddy.
- **Resource Audit:** Systemd-OOMD enabled for AI-workloads, hardware watchdogs corrected, and zram optimized.
- **Structural Audit:** Impermanence paths exhausted, backup logic verified, and B2 endpoints aligned.
- **UX Audit:** Shell workflow aliases (nsw, nlog) fixed and interactive greeting consistent.
- **Immutable Secrets:** Read-only schema defined with automated mapping to SOPS-Nix.
- **Resilience:** S3 Log Sync (hourly) and RAM-buffer strategy fully implemented.

---

## 🧭 Status Overview
| Priority | Task | Complexity | Impact | Status |
| :--- | :--- | :--- | :--- | :--- |
| 🔴 **P1** | **v6.0 Core Hardening** | Medium | High | **[DONE]** |
| 🟠 **P2** | **Deep SRE Audit & Fixes** | Medium | High | **[DONE]** |
| 🟡 **P3** | **Hardware-Bound Identity** | Low | High | **[DONE]** |
| 🟢 **P4** | **Logging & Cloud-Sync** | Low | Medium | **[DONE]** |
| 🔵 **P5** | **Documentation & Polish** | Low | Low | **[DONE]** |

---

## 🛠️ Post-Sortie: User Action List

### 🔴 CRITICAL (Deployment)
- [ ] **Manual Secret Population:** `secrets/secrets.yaml` befüllen (siehe `INJECTION_GUIDE.md`).
- [ ] **First Boot Identity:** TPM-Bindung nach dem ersten `rebuild` verifizieren.

### 🟠 HIGH (Validation)
- [ ] **S3 Verification:** Ersten erfolgreichen Log-Sync im Backblaze-Bucket prüfen.
- [ ] **Backup Test:** Manuellen Restic-Check durchführen.

---

### 🧩 System Maintenance & Artifacts
- [x] **README.md:** Updated to v6.0 (Aviation-Grade).
- [x] **INJECTION_GUIDE.md:** Step-by-step secret population guide.
- [x] **SSoT Ports:** Fully aligned camelCase registry.
- [x] **SSoT Configs:** Centralized domain and hardware values.

*Final Sync: 2026-05-09 | Status: STABLE - OVER AND OUT*

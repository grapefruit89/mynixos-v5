---
title: 30-security-hardening
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/core/kernel-hardening.nix
    anchor: kernel-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/kernel-hardening.nix
  - path: modules/security/no-legacy.nix
    anchor: kernel-diet
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/security/no-legacy.nix
  - path: modules/core/fail2ban.nix
    anchor: fail2ban-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/fail2ban.nix
  - path: modules/core/firewall.nix
    anchor: nftables-mastery
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/firewall.nix
  - path: modules/security/hardened-core.nix
    anchor: service-slimming
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/security/hardened-core.nix
  - path: modules/core/lib-helpers.nix
    anchor: mkHardenedService
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/lib-helpers.nix
---

# Cluster 30: Security Hardening

Dieses Dokument bildet den Kern der Zero-Trust-Architektur von mynixos. Es beschreibt die Härtungs-Maßnahmen auf Kernel-, Netzwerk- und Dienste-Ebene.

---

## 🛡️ Kernel Mastery & Hardening (anchor: kernel-hardening)

Der Kernel wird als "Root of Trust" betrachtet und gegen bekannte Angriffsvektoren abgesichert. Die Konfiguration erfolgt in `modules/core/kernel-hardening.nix`.

### 🏛️ Kern-Strategien
- **Hardened Kernel**: Nutzung von `pkgs.linuxPackages_hardened` für proaktiven Exploit-Schutz.
- **Sysctl Hardening**: Zementierung von Sicherheits-Parametern (z.B. `kernel.kptr_restrict = 2`, `kernel.kexec_load_disabled = 1`).
- **Boot Parameters**: Aktivierung von Memory Protection (`slab_nomerge`, `init_on_free=1`).

### ✂️ Kernel Surgical Diet (anchor: kernel-diet)
In `modules/security/no-legacy.nix` werden unnötige Subsysteme und legacy Dateisysteme (ext2, jfs, reiserfs) deaktiviert, um die Angriffsfläche zu minimieren.

---

## 🧱 Nftables Firewall Mastery (anchor: nftables-mastery)

Nftables ist das einzige erlaubte Firewall-Backend. Es ermöglicht atomare Rulesets und UID-basierte Filterung. Die Konfiguration liegt in `modules/core/firewall.nix`.

### 🛡️ Sicherheits-Features
- **Rate Limiting**: Schutz gegen Brute-Force auf SSH und HTTPS.
- **East-West Isolation**: Strenge Trennung zwischen Diensten auf dem Loopback-Interface.
- **Outbound Filtering**: Nur autorisierte Dienste (via UID) dürfen Verbindungen ins Internet aufbauen.

---

## 🕵️ Brute-Force Protection (Fail2ban) (anchor: fail2ban-hardening)

Fail2ban bietet aggressiven Schutz durch Inspektion von Logs. Die Konfiguration erfolgt in `modules/core/fail2ban.nix`.

- **Caddy-Integration**: Spezielle Filter für Caddy-JSON-Logs zur Erkennung von fehlgeschlagenen SSO-Logins und Bot-Scannern.
- **Incremental Banning**: Verlängerung der Ban-Zeit bei wiederholten Verstößen (bis zu einer Woche).

---

## 🧹 Service Hardening & Sandboxing (anchor: service-slimming)

Dienste werden nach dem Prinzip des "Least Privilege" isoliert.

### 🏛️ Der srvos-Standard (anchor: mkHardenedService)
Über die `mkService` Factory in `modules/core/lib-helpers.nix` erhalten alle Dienste automatisch:
- `ProtectSystem = "strict"` (Nur-Lese-Zugriff auf das Basissystem).
- `PrivateDevices = true` (Kein Zugriff auf Hardware-Nodes, außer explizit via Bind-Paths für GPU).
- `NoNewPrivileges = true`.

### 🧹 Service Slimming
In `modules/security/hardened-core.nix` werden ungenutzte Systemdienste (Bluetooth, Cups, ModemManager) deaktiviert.

---

## ✅ Verifizierung

```bash
# 1. Prüfe geladene Kernel-Module (Audit Service)
systemctl start kernel-module-audit && journalctl -u kernel-module-audit

# 2. Prüfe Nftables Regeln
nft list ruleset | grep "chain output"

# 3. Prüfe Fail2ban Status
fail2ban-client status sshd

# 4. Prüfe Sandboxing eines Dienstes (Beispiel: Caddy)
systemd-analyze security caddy.service
```

---

## 🔗 Quellen & Verweise

### Externe Repositories (NixOS-Native)
- [numtide/srvos](https://github.com/numtide/srvos) - Vorlage für Server-Hardening
- [fail2ban/fail2ban](https://github.com/fail2ban/fail2ban) - Intrusion Prevention
- [google/nsjail](https://github.com/google/nsjail) - (Referenz) Prozess-Isolation

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/kernel-hardening.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/firewall.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/fail2ban.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/core/kernel-hardening.nix -->
<!-- mcp: repo_v5/modules/core/firewall.nix -->
<!-- mcp: repo_v5/modules/core/fail2ban.nix -->
<!-- mcp: repo_v5/modules/security/hardened-core.nix -->

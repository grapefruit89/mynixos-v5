# Zentrale To-Do-Liste – alle offenen Aufgaben

Diese Datei ist die Single Source of Truth (SSoT) für alle Aufgaben, Verbesserungen und Härtungen im Distiller-Projekt (NixHome v6.0).

| ID | Quelle | Beschreibung | Betroffene Dateien | Priorität | Status | Notizen |
|----|--------|--------------|--------------------|-----------|--------|---------|
| TODO-001 | AUDIT_MASTER_TRACKER, CURRENT_STATUS | Implementiere WAL/SHM Exclusions im Storage Mover Script. | `repo_v5/modules/storage/storage-mover.nix` | hoch | erledigt | |
| TODO-002 | AUDIT_MASTER_TRACKER | Lokale ntfy-Instanz statt ntfy.sh implementieren. | `repo_v5/modules/monitoring/gatus.nix` | mittel | offen | |
| TODO-003 | HARDENING_OPTIMIZATIONS_AUDIT | **KRITISCH:** Systemd-Härtung für Blocky DNS implementieren. | `repo_v5/modules/services/blocky.nix` | hoch | erledigt | |
| TODO-004 | HARDENING_OPTIMIZATIONS_AUDIT | Ergänzung fehlender Härtungs-Flags für Pocket-ID. | `repo_v5/modules/services/pocket-id.nix` | hoch | erledigt | |
| TODO-005 | HARDENING_OPTIMIZATIONS_AUDIT | Globale mkService Härtungs-Flags vervollständigen. | `repo_v5/modules/core/lib-helpers.nix` | hoch | erledigt | ProtectKernelLogs, ProtectKernelModules etc. bereits vorhanden. |
| TODO-006 | HARDENING_OPTIMIZATIONS_AUDIT | API Rate-Limiting via Caddy & Fail2ban (L7). | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |
| TODO-007 | HARDENING_OPTIMIZATIONS_AUDIT | Auto-Block von Honeypot-Hits via Fail2ban/nftables. | `repo_v5/modules/services/caddy.nix`, `firewall.nix` | mittel | offen | |
| TODO-008 | HARDENING_OPTIMIZATIONS_AUDIT | TPM PCR Measurements (Hardware Integrity) in Boot-Watchdog. | `repo_v5/modules/services/boot-watchdog.nix` | mittel | offen | |
| TODO-009 | MAINTAINABILITY_UX_AUDIT | SFTPGo als Multi-Protokoll Gateway (WebDAV/SFTP). | — | niedrig | abgelehnt | Laut `forbidden-tech.nix` und ADR explizit abgelehnt (KISS). |
| TODO-010 | MAINTAINABILITY_UX_AUDIT | Host-Metriken (Disk, CPU, Mem) in Vector integrieren. | `repo_v5/modules/services/vector.nix` | hoch | offen | |
| TODO-011 | MAINTAINABILITY_UX_AUDIT | RFC1918 Hardcoded IP Detector (Assertion). | `repo_v5/modules/security/security-assertions.nix` | mittel | offen | |
| TODO-012 | MAINTAINABILITY_UX_AUDIT | Warnung für `mkForce` Missbrauch in App-Modulen. | `repo_v5/modules/security/security-assertions.nix` | mittel | offen | |
| TODO-013 | MAINTAINABILITY_UX_AUDIT, GROK_AUDIT | Legacy Tech Cleanup (Entferne Tailscale/ZFS Reste). | `repo_v5/modules/core/lib-helpers.nix`, `BACKEND.md` | mittel | offen | Reste wie `tailscaleOnly` in Factory noch vorhanden. |
| TODO-014 | MAINTAINABILITY_UX_AUDIT | Batch Update aller NMS-Blöcke auf v4.2 Schema. | diverse in `repo_v5/` | mittel | teilweise | |
| TODO-015 | AUDIT_MASTER_TRACKER | IPv6 Parity in nftables (ssh_meter_v6, ICMPv6 ND). | `repo_v5/modules/security/firewall.nix` | mittel | erledigt | Bereits in `firewall.nix` vorhanden. |
| TODO-016 | TECHNICAL_DEBT [C-03] | Physischen USB-Key mit Age-Fallback erstellen und in `secrets.nix` final einbinden. | `secrets.nix` | hoch | offen | |
| TODO-017 | TECHNICAL_DEBT [H-09] | Integration von `geoip-shell` oder einem systemd-timer für nftables Geoblock. | `repo_v5/modules/security/firewall.nix` | mittel | offen | |
| TODO-018 | TECHNICAL_DEBT [H-07] | Kontinuierliche Spiegelung aller IPv4 nftables Sets nach IPv6. | `repo_v5/modules/security/firewall.nix` | mittel | offen | |
| TODO-019 | TECHNICAL_DEBT [M-08] | Implementierung eines PoW-Verfahrens (z.B. Hashcash) in der Challenge-Seite. | `repo_v5/modules/services/caddy.nix` | mittel | offen | |
| TODO-020 | TECHNICAL_DEBT [M-09] | Token-basierte Whitelist für bekannte API-Clients in Caddy. | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |
| TODO-021 | TECHNICAL_DEBT [M-10] | WebDAV für Obsidian via Caddy (SSO-protected) nachrüsten. | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |

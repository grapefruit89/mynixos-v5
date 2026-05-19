# 🚀 SSoT: Projekt-Status & Offene Punkte (NixHome v7.1)

**Letzte Konsolidierung:** 19. Mai 2026
**Zentrale SSoT:** Diese Datei ist die einzige Quelle für den aktuellen Projektfortschritt.

---

## 📌 Aktueller Fokus: Dokumentations-Enrichment (v7.1)
**Status:** 10 / 13 Cluster abgeschlossen (~77%)

### ✅ Erledigt (Kürzlich)
- [x] **SSO Enforcement:** Tailscale-Bypässe entfernt, Pocket-ID SSoT.
- [x] **Storage Strategy:** ABC-Tiering & Restic/Rclone Mapping (Guide 40).
- [x] **Identity & Auth:** Pocket-ID SSO & Forward-Auth angereichert (Guide 50).
- [x] **Monitoring:** Gatus & Netdata Integration (Guide 58).
- [x] **Media Stack:** QuickSync & RAM-Transcoding (Guide 60).
- [x] **Matrix:** Conduit (Rust) & Federation (Guide 80).
- [x] **Docs Cleanup:** Auflösung von `reference/` und `specs/` in `guides/`.

---

## 📝 Offene Punkte (Priorisiert)

### 🔴 Hochprio (Nächste Schritte)
1. **[x] Guide 90 (GitHub Workflows):**
   - CI/CD Pipelines für NixOS Flakes dokumentiert.
   - Forgejo Integration & Sovereign Git Strategie (Modul implementiert).
   - Integration von `SSO-TODO.md` abgeschlossen.
2. **[x] Guide 95 (Gaming AMP):**
   - FHS-Environments für Game-Server (Modul `_amp-fhs.nix` dokumentiert).
   - AMP (Application Management Panel) Konfiguration (Modul `amp.nix` aktualisiert).
3. **[x] Guide 99 (Recovery):**
   - Bootstrap-Prozess von USB/Stick (Modul `recovery-usb.nix` dokumentiert).
   - Master-Key Management (Tiered Hierarchy) & Disaster Recovery Pfade (QR-Unlock).


### 🟡 Mittelprio (System-Feinschliff)
- [x] **Secrets:** `secrets.yaml` finalisiert (basiert auf `secrets.yaml.example`).
- [x] **Backup:** Verifikation der Backup-Integrität auf `/persist` (Wöchentliches Audit-Service implementiert).
- [x] **Networking:** IPv6 Geoblocking Sets feinjustiert (IPv6 Parity & Tor-Fix).


### 🔵 Langzeit / Cleanup
- [ ] **Final Audit:** Konsistenzprüfung aller Cross-Links und MCP-Indizes.
- [ ] **Archivierung:** Letzte Reste aus `archive_root` sichten und ggf. löschen.

---

## 🛠️ Technische Anker (SSoT)
- `# anchor: quicksync-mastery` (Guide 60)
- `# anchor: arr-tiering` (Guide 60)
- `# anchor: n8n-workflows` (Guide 70)
- `# anchor: matrix-conduit` (Guide 80)
- `# anchor: persistence-core` (modules/core)

**Nächster Startpunkt:** Guide 90 (GitHub Workflows) Recherche.

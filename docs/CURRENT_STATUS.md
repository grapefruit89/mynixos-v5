# Current Status - NixHome v7.1 Strict (Production Hardened)

- **Was wurde gerade getan?** Komplette Reorganisation und Konsolidierung der Dokumentation abgeschlossen. Alle losen Guides, Root-Dokumente und Referenzen wurden in 13 thematische Hauptguides (00-99) überführt. Das Repository ist nun sauber strukturiert und folgt dem SSoT-Prinzip (Single Source of Truth).
- **Was ist der nächste Schritt?** Hardware-Deployment auf dem Fujitsu Q958 (Benutzer-Aktion). Nach erfolgreichem Deployment: Verifizierung der mTLS-Zertifikate und TPM-Enrollment.
- **Gibt es Fehler oder Blockaden?** Keine. Alle Architektur-Entscheidungen (No Tailscale, No Docker, No ZFS) sind dokumentiert und implementiert.
- **Wichtige Dokumente:**
  - `docs/guides/README.md`: Index der neuen Dokumentationsstruktur.
  - `docs/reference/ANTIPATTERN.md`: Liste der abgelehnten Technologien und Muster.
  - `docs/reference/LAYER_CONSOLIDATED.md`: Übersicht der System-Layer (00-90).
  - `docs/reference/RISKS.md`: Katalog der akzeptierten Sicherheits- und Betriebsrisiken.

*Dokumentation konsolidiert am 18. Mai 2026.*

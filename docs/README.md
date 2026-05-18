# NixHome v7.1 Strict Documentation

Willkommen in der zentralen Dokumentation für das **NixHome v7.1 Strict** Projekt (Codename: Distiller). Diese Dokumentation ist nach dem SSoT-Prinzip (Single Source of Truth) aufgebaut und direkt mit der technischen Umsetzung in den Nix-Modulen verzahnt.

## 🗺️ Einstiegspunkte

### 📖 [Guides](./guides/README.md)
Die thematisch konsolidierten Hauptguides für alle Systembereiche:
- **00-40**: Core, Ingress, Networking & Storage.
- **50-80**: Monitoring, Media, Knowledge & Matrix.
- **90-99**: Workflows, Gaming & Recovery.

### 🏛️ [ADR (Architectural Decision Records)](./adr/README.md)
Die verbindlichen Architekturentscheidungen des Projekts. Jede ADR ist semantisch mit den entsprechenden Nix-Modulen verknüpft und enthält Verifikationsbefehle.

### 🛠️ Zentrale Referenzen
- **[ANTIPATTERN.md](./ANTIPATTERN.md)**: Was wir explizit NICHT tun (Zero-Trust, No-Docker, No-Flake-Parts).
- **[LAYER_CONSOLIDATED.md](./LAYER_CONSOLIDATED.md)**: Die 7-Layer-Architektur des Systems.
- **[RISKS.md](./RISKS.md)**: Bekannte Risiken und deren Mitigation.
- **[NIXMETA_SCHEMA.json](./NIXMETA_SCHEMA.json)**: Technische Spezifikation für Metadaten-Header.

### 📂 [Archive](./archive/)
Historische Dokumente, abgelehnte Vorschläge und legacy Audits zur Nachvollziehbarkeit.

---
*Status: Production Hardened | Letzte Aktualisierung: Mai 2026*

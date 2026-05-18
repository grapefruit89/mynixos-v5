# ⚠️ NixHome Risk Registry (RISKS.md)

Dieses Dokument listet akzeptierte Restrisiken auf, die derzeit nicht als sofortige Aufgaben (TODOs) eingestuft sind, aber die Stabilität oder Sicherheit des Systems beeinflussen könnten.

## 🔴 Kritische Risiken (Disaster Recovery)

### [C-03] SOPS-Deadlock bei Totalausfall von Tier A
- **Problem:** SSH-Hostkeys liegen auf /persist (NVMe). Wenn diese Partition physisch stirbt, kann SOPS keine Secrets mehr entschlüsseln.
- **Konsequenz:** System bootet, aber alle Dienste (DBs, Proxy) schlagen fehl. Kein Remote-Access möglich.
- **Status:** Akzeptiertes Risiko bis zur Umsetzung von TODO-016.

## 🟠 Sicherheit & Netzwerk

### [H-09] Statischer Geoblock
- **Problem:** IP-Ranges in irewall.nix sind manuell gepflegt und veralten.
- **Konsequenz:** Angreifer aus zugelassenen Ländern kommen durch; legitime User aus geänderten Ranges werden blockiert.
- **Status:** Akzeptiertes Risiko bis zur Umsetzung von TODO-017.

### [H-07] IPv6 Parität
- **Problem:** Viele Security-Regeln sind IPv4-fokussiert.
- **Konsequenz:** Umgehung der Limits via IPv6.
- **Status:** Akzeptiertes Risiko bis zur Umsetzung von TODO-018.

## 🟡 Performance & UX

### [M-08] JS-Challenge vs. Headless Bots
- **Problem:** Die aktuelle 13+37 Challenge hält nur einfache Scripte ab. Headless Browser (Puppeteer) können sie lösen.
- **Konsequenz:** Gezielte Bot-Angriffe überwinden den Rate-Limit-Schutz.
- **Status:** Akzeptiertes Risiko bis zur Umsetzung von TODO-019.

### [M-09] API-Dienste Rate-Limits
- **Problem:** API-Endpunkte unterliegen dem Stage-0 Limit (30 req/min).
- **Konsequenz:** Mobile Apps könnten bei intensiver Synchronisation blockiert werden.
- **Status:** Akzeptiertes Risiko bis zur Umsetzung von TODO-020.

## 🔵 Architektur

### [M-10] Dateizugriffs-Evolution (SFTP vs WebDAV)
- **Problem:** Obsidian-Vault-Sync erfordert WebDAV; native Windows-Netzlaufwerke sind komfortabler.
- **Konsequenz:** Eingeschränkte UX beim Dateizugriff für spezifische Apps.
- **Status:** Strategische Entscheidung (SFTP bevorzugt), WebDAV wird bei Bedarf via TODO-021 nachgerüstet.

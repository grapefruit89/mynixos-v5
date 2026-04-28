# 📓 NixHome Technical Debt & Risk Registry

Dieses Dokument listet bekannte Einschränkungen, akzeptierte Restrisiken und geplante Architektur-Verbesserungen auf.

## 🔴 Kritische Risiken (Disaster Recovery)

### [C-03] SOPS-Deadlock bei Totalausfall von Tier A
- **Problem:** SSH-Hostkeys liegen auf `/persist` (NVMe). Wenn diese Partition physisch stirbt, kann SOPS keine Secrets mehr entschlüsseln. Der Fallback-Pfad auf Tier B ist vorbereitet, aber aktuell nicht mit einem Live-Key befüllt.
- **Risiko:** System bootet, aber alle Dienste (Cloudflare, Tailscale, DBs) schlagen fehl. Kein Remote-Access möglich.
- **Lösung:** Physischen USB-Key mit Age-Fallback erstellen und in `secrets.nix` final einbinden.

## 🟠 Sicherheit & Netzwerk

### [H-09] Statischer Geoblock
- **Problem:** IP-Ranges in `firewall.nix` sind manuell gepflegt und veralten.
- **Risiko:** Angreifer aus zugelassenen Ländern kommen durch; legitime User aus geänderten Ranges werden blockiert.
- **Lösung:** Integration von `geoip-shell` oder einem systemd-timer, der die nftables-Sets wöchentlich via MaxMind API aktualisiert.

### [H-07] IPv6 Parität
- **Problem:** Viele Security-Regeln sind IPv4-fokussiert.
- **Risiko:** Umgehung der Limits via IPv6.
- **Lösung:** Kontinuierliche Spiegelung aller IPv4 nftables Sets nach IPv6.

## 🟡 Optimierung & UX

### [M-08] JS-Challenge vs. Headless Bots
- **Problem:** Die aktuelle `13+37` Challenge hält nur einfache Scripte ab. Headless Browser (Puppeteer) können sie lösen.
- **Risiko:** Gezielte Bot-Angriffe überwinden den Rate-Limit-Schutz.
- **Lösung:** Implementierung eines echten Proof-of-Work (PoW) Verfahrens (z.B. Hashcash) in der Challenge-Seite.

### [M-09] API-Dienste Rate-Limits
- **Problem:** API-Endpunkte (arr-Apps) sind von der Challenge befreit, unterliegen aber dem Stage-0 Limit (30 req/min).
- **Risiko:** Mobile Apps könnten bei intensiver Synchronisation blockiert werden.
- **Lösung:** Token-basierte Whitelist für bekannte API-Clients in Caddy.

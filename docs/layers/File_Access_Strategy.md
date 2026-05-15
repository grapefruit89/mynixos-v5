# 📂 File Access Strategy

Entscheidungsmatrix für den modernen Dateizugriff auf NixHome.

## 🎯 Status Quo: SFTP (Primary)
Da SSH bereits auf Port `53844` (limitiert auf LAN/Tailscale) aktiv ist, wird **SFTP** als primäre Methode für den Dateizugriff genutzt.

| Client | Methode | Empfehlung |
| :--- | :--- | :--- |
| **Android** | Solid Explorer / CX File Explorer | SFTP-Verbindung via Tailscale-IP |
| **Windows** | WinSCP / sshfs-win | Einbindung als Netzlaufwerk oder File-Manager |
| **Linux** | Nautilus / Dolphin / sshfs | Nativ via `sftp://` |

**Vorteil:** Kein zusätzlicher Dienst nötig, maximale Sicherheit durch SSH-Hardening.

---

## 🛠️ Optionale Erweiterungen (Future Planning)

### 1. WebDAV (via Caddy)
**Einsatzbereich:** Obsidian Vault Sync oder SSO-geschützter Dateizugriff für Dritte.
- **Vorteil:** Nutzt Port 443 und Pocket-ID (SSO).
- **Nachteil:** Erfordert Caddy-Plugin und ist oft langsamer als SFTP.

### 2. SMB/CIFS
**Einsatzbereich:** Stationäre Windows-PCs im LAN (z.B. Media-Editing).
- **Vorteil:** Native Performance unter Windows.
- **Nachteil:** Protokoll-Overhead, komplexeres Hardening.

---

## 📋 Implementierungs-Leitfaden (WebDAV)
Falls WebDAV benötigt wird, ist folgendes Muster zu verwenden:

```nix
# Vorbereitung in modules/services/caddy.nix
services.caddy.package = pkgs.caddy.withPlugins [ pkgs.caddyPlugins.webdav ];

# Dienst-Definition
services.caddy.virtualHosts."dav.${domain}" = {
  extraConfig = ''
    import sso_auth
    webdav {
      root /storage/media
      prefix /
    }
  '';
};
```

--- 
*Zuletzt aktualisiert: 2026-04-29 | Strategie: SFTP-First*

---
title: "🎮 Gaming & AMP (Native FHS)"
domain: 95
category: services/gaming
status: [ACTIVE-SSoT]
capabilities: [game-server, fhs-env, steamcmd, amp-panel]
sources: [CubeCoders AMP Docs, NixOS Wiki: FHS]
last_reviewed: 2026-05-19
related:
  adr: docs/adr/ADR-013-Media-Performance-Priority.md
test: tests/gaming.nix
---

# 🎮 Guide 95: Gaming & AMP (Native FHS)

Dieses Dokument beschreibt die native Integration des **AMP Game Server Panels** in der NixHome-Umgebung. Wir verzichten bewusst auf Docker und nutzen stattdessen **FHS-Sandboxing**.

## 🏛️ 1. Die Architektur: FHS-Sandboxing

Da Game-Server oft vorkompilierte Binaries und spezifische Pfade (`/bin/bash`, `/usr/lib`) erwarten, nutzen wir ein **Filesystem Hierarchy Standard (FHS)** Environment.

### 🛠️ Konfiguration
```nix
my.services.amp.enable = true;
```

### 📦 AMP FHS Sandbox (`modules/apps/_amp-fhs.nix`)
- **Basis:** `pkgs.buildFHSEnv` stellt eine kompatible Laufzeitumgebung bereit.
- **Dependencies:** .NET 8 SDK, glibc, OpenSSL, SteamCMD, libstdc++, etc.
- **Vorteil:** Game-Server "denken", sie laufen auf einem Standard-Linux (Ubuntu/Debian), während sie tatsächlich sicher isoliert auf NixOS laufen. ✅

---

## 🛠️ 2. AMP Service Konfiguration

### 💎 Der Service (`modules/services/amp.nix`)
- **User:** Eigener unprivilegierter System-User `amp` (UID `2109`).
- **Persistence:** Alle Instanzen und Daten liegen unter `/var/lib/amp` (persistent via `/persist`).
- **Network:** Direkter Netzwerkzugriff notwendig (kein `PrivateNetwork`), um Game-Ports dynamisch binden zu können.
- **Proxy:** Erreichbar über `https://amp.m7c5.de/` (Zone: Admin).

### 🚀 Erstmaliges Bootstrapping
1. **Modul aktivieren:** `my.services.amp.enable = true;` in `configuration.nix`.
2. **Rebuild:** `sudo nixos-rebuild switch`.
3. **Instanz-Manager:**
   ```bash
   sudo -u amp -i
   # Du befindest dich nun in der FHS-Shell
   ampinstmgr QuickStart <DEINE_LIZENZ>
   ```

---

## 🎮 3. Game-Server Management

### 🛡️ Sicherheit
Obwohl AMP als User `amp` läuft, spawned es weitere Prozesse. 
- **Sandboxing:** Wir nutzen `ProtectSystem=strict` für den Master-Service.
- **Isolation:** Game-Server sollten innerhalb von AMP mit eigenen "Instances" isoliert werden.

### 🔓 Firewall-Management
Game-Server benötigen spezifische Ports. Diese müssen manuell in `firewall.nix` oder über eine Host-spezifische Konfiguration geöffnet werden:

```nix
# Beispiel: Minecraft
networking.firewall.allowedTCPPorts = [ 25565 ];
```

---

## ✅ Verifizierung

```bash
# 1. Prüfe AMP Status
systemctl status amp --no-pager
# Positiv-Test: Web-UI erreichbar (Local)
curl -f -s http://127.0.0.1:20080 | grep "AMP"

# 2. Prüfe FHS-Sandbox Funktionalität
# Betrete die FHS-Shell und prüfe .NET Version
sudo -u amp amp-fhs -c "dotnet --version"

# 3. Prüfe SteamCMD Verfügbarkeit
sudo -u amp amp-fhs -c "steamcmd +quit"

# 4. Negativ-Test: AMP darf NICHT auf 0.0.0.0 binden (nur localhost hinter Caddy)
! ss -tulpn | grep ":20080" | grep "0.0.0.0"
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [CubeCoders/AMP](https://cubecoders.com/AMP) - Game Server Panel
- [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) - Valve CLI Client

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/amp.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/_amp-fhs.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/modules/services/amp.nix -->
<!-- mcp: nixos:repo_v5/modules/apps/_amp-fhs.nix -->

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*

# 🎮 Guide 95: Gaming & AMP (Native FHS)

---
title: 🎮 Gaming & AMP (Native FHS)
category: services/gaming
status: [ACTIVE-SSoT]
capabilities: [game-server, fhs-env, steamcmd, amp-panel]
sources: [CubeCoders AMP Docs, NixOS Wiki: FHS]
last_reviewed: 2026-05-19
---

Dieses Dokument beschreibt die native Integration des **AMP Game Server Panels** in der NixHome-Umgebung. Wir verzichten bewusst auf Docker und nutzen stattdessen **FHS-Sandboxing**.

## 🏛️ 1. Die Architektur: FHS-Sandboxing

Da Game-Server oft vorkompilierte Binaries und spezifische Pfade (`/bin/bash`, `/usr/lib`) erwarten, nutzen wir ein **Filesystem Hierarchy Standard (FHS)** Environment.

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

## 📝 Nächste Schritte

- [ ] **TODO-025:** Implementierung eines automatischen Firewall-Wrappers für AMP (optional).
- [ ] **TODO-026:** Monitoring der Game-Server Auslastung via Netdata/Prometheus.
- [ ] **Final Check:** Verifikation der SteamCMD Funktionalität innerhalb der FHS-Sandbox.

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*

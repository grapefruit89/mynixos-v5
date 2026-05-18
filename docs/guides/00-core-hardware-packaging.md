# Cluster 00: Core, Hardware & Packaging

### Inhalt aus `GUIDE-Hardware-Acceleration-DeepDive.md`

---
title: 🚀 Hardware Acceleration Deep-Dive (The Anti-Stuttering Protocol)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [quicksync-mastery, low-latency-streaming, 4k-transcoding]
sources: [Intel Media Driver Docs, Jellyfin Hardware Acceleration Guide]
---

# 🚀 Das Anti-Stuttering Protokoll

Wenn Medien ruckeln, ist das ein Versagen der Hardware-Abstraktion. Wir lösen dies durch direkten GPU-Zugriff.

## 🏛️ 1. Die Treiber-Wahl (Layer 00-core)
Für den i3-9100 (Coffee Lake) ist der `intel-media-driver` (iHD) zwingend.
- **NixOS Config:**
```nix
hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver # Der moderne iHD Treiber
    intel-vaapi-driver # Fallback für ältere Apps
    vaapiVdpau
    libvdpau-va-gl
  ];
};
```

## 🛡️ 2. Jellyfin Permission-Fix (Layer 40-media)
Ruckler entstehen oft durch fehlende Leserechte auf dem Render-Node.
- **Lösung:** Der Jellyfin-User muss in der Gruppe `render` und `video` sein.
- **Systemd-Hardening:**
```nix
systemd.services.jellyfin.serviceConfig = {
  DeviceAllow = [ "/dev/dri/renderD128 rw" ];
  PrivateDevices = false; # Muss für GPU-Zugriff false sein
};
```

## ⚡ 3. Die "Smooth-Stream" Settings (In Jellyfin)
In der Admin-Konsole unter "Transcoding":
1. **Hardware-Beschleunigung:** Intel QuickSync (QSV) wählen.
2. **Low-Power Encoding:** Aktivieren (spart massiv Energie).
3. **Hardware-Decodierung:** Alles anhaken (H264, HEVC, MPEG2, VC1, VP8, VP9).

## 📊 Performance-Check
Führe `intel_gpu_top` (aus dem Paket `intel-gpu-tools`) aus. Wenn der Balken bei "Video" ausschlägt und die CPU bei ~2% bleibt, ist das Ziel erreicht.

---

### Inhalt aus `GUIDE-Intel-QuickSync-NixOS.md`

---
title: ⚡ Intel QuickSync & iGPU (NixOS-Native Standard)
category: architecture/hardware
status: [ACTIVE-SSoT]
capabilities: [hardware-transcoding, quicksync, vaapi, energy-efficiency]
sources: [https://perfectmediaserver.com/02-tech-stack/nixos/, ironicbadger blog]
---

# ⚡ Intel QuickSync: Der Transcoding-Standard

Für den Fujitsu Q958 (Intel UHD 630) ist QuickSync der "Heilige Gral". Wir erreichen 4K-Transcoding bei minimalem Stromverbrauch (~35W).

## 🛡️ SRE-Entscheidung: Host-Native statt VM-GVT-g
Wir verzichten auf GVT-g (GPU-Slicing), da es in der Praxis zu Instabilitäten führt. Stattdessen nutzen wir direktes Hardware-Rendering auf dem NixOS-Host oder innerhalb nativer Dienste.

## ⚙️ NixOS Hardware-Konfiguration
Um die iGPU für Dienste wie Jellyfin oder Plex verfügbar zu machen, deklarieren wir:

```nix
hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver # iHD Treiber für UHD 630
    vaapiIntel         # VA-API Support
    libvdpau-va-gl
  ];
};
```

## 🧩 Berechtigungs-Management (Layer 00-core)
Dienste, die auf die iGPU zugreifen, müssen in der Gruppe `render` oder `video` sein:
```nix
users.users.jellyfin.extraGroups = [ "render" "video" ];
```

## 🚀 Monitoring
Wir nutzen `intel-gpu-tools`, um die Auslastung der iGPU live zu überwachen:
- Befehl: `intel_gpu_top`

---

### Inhalt aus `GUIDE-Nixpkgs-Engine-Mastery.md`

---
title: ⚙️ Nixpkgs Engine Mastery (Architecture Core)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [kernel-management, package-overlays, by-name-standard]
sources: [nixpkgs/pkgs/top-level/]
---

# ⚙️ Nixpkgs Engine: Unter der Haube

Um mynixos auf Aviation-Grade Level zu betreiben, müssen wir verstehen, wie der Engine-Room von Nixpkgs funktioniert.

## 🏛️ 1. Kernel Management (Layer 00-core)
In `engine-linux-kernels.nix` sehen wir, wie Kernel deklariert werden.
- **Pattern:** Wir können für den Tower gezielt den `linuxPackages_latest` oder `linuxPackages_hardened` wählen.

## 🧩 2. Der By-Name Standard
Nixpkgs nutzt das `pkgs/by-name` Pattern. Wir kopieren diesen Standard für unsere eigenen Pakete in `mynixos/pkgs/`.
- **Vorteil:** Automatische Erkennung von Paketen ohne manuelle Imports in `all-packages.nix`.

## ⚙️ 3. Globale Konfiguration (`config.nix`)
Hier deklarieren wir systemweite Nixpkgs-Einstellungen:
- `allowUnfree = true;` (Nötig für Intel-Treiber).
- `permittedInsecurePackages = [ ... ];` (Nur im Notfall!).

---

### Inhalt aus `GUIDE-Nixpkgs-Packaging-Standard.md`

---
title: 📦 Nixpkgs Packaging Standard (Aviation-Grade Quality)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [package-creation, testing-standards, automated-updates, meta-excellence]
sources: [Nixpkgs Contributing Guide]
---

# 📦 Der mynixos Packaging Standard

Wir folgen strikt den offiziellen Nixpkgs-Richtlinien, um maximale Kompatibilität und Wartbarkeit zu garantieren.

## 🏛️ 1. Struktur (The by-name Law)
Eigene Pakete werden in `mynixos/pkgs/by-name/` abgelegt.
- **Pfad:** `pkgs/by-name/${prefix}/${name}/package.nix`
- **Vorteil:** Automatische Entdeckung durch Nix ohne manuelle Imports.

## 🛡️ 2. Validierung (passthru.tests)
Jedes Paket **muss** einen Test enthalten.
```nix
passthru.tests = {
  version = testers.testVersion {
    package = finalAttrs.finalPackage;
    command = "${meta.mainProgram} --version";
  };
};
```

## ⚙️ 3. Meta-Attribute (The 7-Gate Quality)
- `description`: Kurz, prägnant, kein Punkt am Ende.
- `license`: Muss exakt dem Upstream entsprechen.
- `mainProgram`: Name der primären Binary.
- `maintainers`: Dein GitHub-Handle.

## 🔄 4. Automated Updates
Nutze `passthru.updateScript = nix-update-script { };`, um Paket-Updates zu automatisieren.

---

### Inhalt aus `GUIDE-Fujitsu-Hardware-Mastery.md`

---
title: 🖥️ Fujitsu Q958 Hardware-Optimierung (Layer 80-monitoring)
category: architecture/hardware
status: [ACTIVE-SSoT]
capabilities: [bios-tuning, power-efficiency, hardware-acceleration, fujitsu-support]
sources: [https://secretmine.de/ (Hardware Category), Fujitsu Technical Docs]
---

# 🖥️ Fujitsu Q958: Die Aviation-Grade Hardware-Basis

Dein Tower (i3-9100, 16GB RAM) ist eine hocheffiziente Maschine. Wir optimieren die physische Schicht für maximalen Durchsatz bei minimalem Verbrauch.

## 🏛️ BIOS-Tuning (SRE Standard)
1.  **C-States:** Aktivierung aller Power-Saving C-States (C10), um den Idle-Verbrauch auf < 10W zu drücken.
2.  **Intel QuickSync:** Sicherstellen, dass die iGPU (UHD 630) permanent aktiviert ist (Primary Display: IGD).
3.  **Auto-Power-On:** Aktivierung nach Stromausfall für ununterbrochenen SRE-Betrieb.

## ⚡ Power Management in NixOS
Wir nutzen das `services.tlp` oder `services.power-profiles-daemon` Modul, um die Fujitsu-Hardware zu steuern.
```nix
services.tlp = {
  enable = true;
  settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
  };
};
```

## 🛡️ SRE-Integrität (Hardware-Watchdog)
Wir nutzen den integrierten Intel-Watchdog (`iTCO_wdt`), um das System bei Kernel-Panics automatisch neu zu starten.

---

### NixOS Versions-Information

**Stand: Mai 2026**

## Aktueller stabiler Kanal
- **Kanal:** `nixos-25.11`
- **Veröffentlichung:** November 2025
- **End of Life:** November 2026 (regulärer Support)
- **Offizielle Quelle:** https://nixos.org/releases/nixos/25.11/

## Wichtig für KI-Assistenten
- `stateVersion = "25.11"` ist **keine Zukunftsmusik**, sondern der **aktuelle, produktive Standard**.
- Verwende diese Versionsangabe ohne Warnungen oder Hinweise auf „nicht existent“.
- Der Kanal `nixos-25.11` ist stabil und wird von `nixpkgs` offiziell unterstützt.

## Historische Versionen (nur zu Referenz)
- `24.11` – LTS, bis November 2026
- `24.05` – veraltet, nicht mehr empfohlen

## Verwendung in diesem Repository
- In `flake.nix` wird `nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";` verwendet.
- In Home‑Manager Konfigurationen wird `home.stateVersion = "25.11";` genutzt (wo sinnvoll).
- Andere `stateVersion`-Werte (z.B. 24.05, 24.11) sind für Kompatibilität belassen.

---

### Onboarding Checkliste

## Overview
To ensure the system is not considered "Production Hardened" before the administrator has verified all initial settings (Secrets, Network, Backups), we use an assertion-based onboarding mechanism.

## The Onboarding Flag
The system uses a Nix-native option instead of a physical flag file.

### Status: Incomplete (Default)
By default, `my.system.onboardingComplete` is set to `false`. This will trigger a **warning** during every `nixos-rebuild`.

### Status: Complete
Once you have verified the following points, you should set the option to `true`:
- [ ] SOPS Secrets are successfully decrypted.
- [ ] Network zones (LAN/VPN) are reachable.
- [ ] Backup paths on `/persist` are configured.
- [ ] SSH access via Keys is verified.

## Configuration
Add the following line to your `configuration.nix`:

```nix
my.system.onboardingComplete = true;
```

If you are currently developing or debugging and want to suppress the warning without finalizing the state, enable the "Bastelmodus":

```nix
my.configs.bastelmodus = true;
```

---

### Inhalt aus `GUIDE-Blank-Snapshot-Persistence.md`

---
title: 🧹 Blank Snapshot Persistence (The Peak of Purity)
category: architecture/hygiene
status: [ACTIVE-SSoT]
capabilities: [root-rollback, btrfs-management, opt-in-persistence]
sources: [https://github.com/Misterio77/nix-config]
---

# 🧹 Blank Snapshot Persistence: "Erase your darlings"

Basierend auf den Patterns von Misterio77 führen wir die System-Hygiene auf das nächste Level.

## 🏛️ Das Prinzip
Anstatt nur Dateien zu löschen, wird das gesamte Root-Dateisystem (`/`) bei jedem Bootvorgang physisch durch einen leeren BTRFS-Snapshot ersetzt.

## 🛠️ Technische Umsetzung (BTRFS Workflow)
1.  **Boot-Phase:** Ein initrd-Script löscht das aktuelle root-Subvolume.
2.  **Rollback:** Ein leerer Snapshot (benannt `blank`) wird als neues `root` eingehängt.
3.  **Opt-in:** Nur Verzeichnisse, die wir in Nix deklarieren, werden nach `/persist` gemountet.

## 🚀 Der SRE-Vorteil
- **Garantierte Reinheit:** Es ist physisch unmöglich, dass sich Schadsoftware oder Konfigurations-Leichen im System verstecken.
- **Reproduzierbarkeit:** Wenn es nach dem Boot läuft, steht es in der Nix-Config. Wenn nicht, existiert es nicht.

## 🧩 Modul-Integration
In mynixos nutzen wir dies in Verbindung mit dem `90-policy` Layer, um die Einhaltung der deklarativen Pflicht zu erzwingen.

---

### Inhalt aus `GUIDE-Industrial-Automation-Standards.md`

---
title: 🏭 Industrial Automation Standards (numtide Patterns)
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [unified-formatting, build-filtering, efficient-development]
sources: [https://github.com/numtide/treefmt, https://github.com/numtide/nix-filter]
---

# 🏭 Industrial Automation: Der SRE Standard

Ein Aviation-Grade System muss wartbar sein. Wir nutzen industrielle Werkzeuge von numtide, um Konsistenz und Performance zu garantieren.

## 🚀 Unified Formatting (`treefmt`)
Wir nutzen `treefmt`, um alle Quellcodedateien im Repository einheitlich zu formatieren.
- **Vorteil:** Keine unnötigen Git-Diffs durch Formatierungs-Kämpfe.
- **Integration:** Ein `pre-commit` Hook stellt sicher, dass nur purer Code in die Knowledge-Base oder das Config-Repo gelangt.

## ⚡ Build Optimization (`nix-filter`)
Große Repositories verlangsamen den Nix-Evaluations-Prozess. Wir nutzen `nix-filter`, um nur die Dateien in den Build-Kontext zu laden, die wirklich gebraucht werden.
- **Ergebnis:** Schnellere `nixos-rebuild` Zeiten auf dem Tower.

## 🛠️ DevShell Integration
Die numtide Tools sind fester Bestandteil unserer `devShell` in mynixos.

---

### Inhalt aus `GUIDE-Nix-Dry-Refactoring.md`

---
title: ✂️ Nix DRY Refactoring (Eliminating Boilerplate)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [code-reduction, custom-lib-extensions, standard-hardening-wrappers]
sources: [r/Nix, numtide/srvos, NixOS Library Docs]
---

# ✂️ DRY Refactoring: Schluss mit der Boilerplate-Hölle

In mynixos folgen wir dem DRY-Prinzip (Don't Repeat Yourself). Wir ersetzen redundante Modul-Strukturen durch zentrale Hilfsfunktionen.

## 🏛️ 1. Das Problem (Boilerplate-Exhaustion)
Bisher brauchte jeder Dendrit (Modul) ~20 Zeilen Standard-Code für Metadaten und `mkEnableOption`. Das erhöht die Fehlerquote und erschwert globale Änderungen.

## ⚙️ 2. Die Aviation-Grade Lösung (Custom Lib)
Wir definieren in der `flake.nix` eine `mynixosLib`, die Standard-Wrappers bereitstellt.

### Beispiel: Der hocheffiziente Service-Wrapper
Anstatt jedes Mal das GPU-Hardening (Kapitel 65) neu zu schreiben, nutzen wir:
```nix
mynixosLib.mkHardenedService {
  name = "jellyfin";
  gpuAccess = true;
  cpuLimit = "50%";
  # ... der Rest wird automatisch generiert
}
```

## 🛡️ 3. SRE-Vorteil
- **Wartbarkeit:** Globale Sicherheits-Updates (z.B. neue systemd-Hardening Flags) müssen nur an **einer Stelle** in der `lib` geändert werden und wirken sofort auf alle 40+ Dienste. ✅
- **Klarheit:** Deine Modul-Dateien enthalten nur noch die **Logik**, nicht die Infrastruktur.

## 🚀 SRE-Anwendung
Wir migrieren alle Layer (00-90) sukzessive auf dieses Wrapper-Modell. Dies ist die Voraussetzung für die "God-Mode" Stabilität v8.5.

---

### Inhalt aus `GUIDE-Pattern-Mining-Nixpkgs.md`

---
title: 🚜 Pattern Mining: Offizielle Nixpkgs Module
category: architecture/learning
status: [ACTIVE-SSoT]
capabilities: [systemd-hardening, module-structure, official-standards]
sources: [/home/Knowledge-Pipeline/raw/sources/nixpkgs-modules/]
---

# 🚜 Pattern Mining: Die Weisheit der Core-Maintainer

Wir nutzen die offiziellen NixOS-Module (`nixpkgs/nixos/modules`) als unsere primäre Quelle für Aviation-Grade Konfigurationen.

## 🏛️ Warum wir das tun?
Jedes Modul in nixpkgs wurde von der Community gereviewt. Es enthält:
- **Best-Practice systemd-Einheiten:** (z.B. `DynamicUser`, `ProtectSystem`).
- **Validierte Optionen:** (Typ-Prüfung für jede Einstellung).
- **Integrierte Tests:** (Wir sehen, wie die Maintainer den Dienst testen).

## 📂 Lokales Archiv
Du findest die Rohdateien deiner Dienste unter:
`/home/Knowledge-Pipeline/raw/sources/nixpkgs-modules/`

Nutze diese Dateien als Vorlage, wenn du einen neuen Dendriten in `mynixos` erstellst.

## 📂 Dein komplettes Anschauungsmaterial (Source-Modules)
Hier sind die offiziellen Vorlagen für deinen Tower:
- **Core:** sshd, nftables, fail2ban, sops
- **Ingress:** caddy, adguardhome, tailscale
- **Media-Stack:** sonarr, radarr, lidarr, prowlarr, jellyfin
- **Storage & Backup:** mergerfs, snapraid, restic, postgresql
- **Knowledge & Identity:** paperless, vaultwarden, conduit, home-assistant

## 💎 Hidden Gems (Erweiterte Suche)
Wir haben weitere hochkarätige Blaupausen identifiziert:
- **Search:** searx (SearXNG Standard)
- **Media:** readarr (Books), servarr-logic (Core Architecture)
- **Ops:** atticd (Binary Cache), aria2 (Pro-Downloader)

---
### Inhalt aus NIXOS_VERSION_INFO.md
# NixOS Version & Channel Information

**Stand: Mai 2026**

## Aktueller stabiler Kanal
- **Kanal:** `nixos-25.11`
- **VerÃ¶ffentlichung:** November 2025
- **End of Life:** November 2026 (regulÃ¤rer Support)
- **Offizielle Quelle:** https://nixos.org/releases/nixos/25.11/

## Wichtig fÃ¼r KI-Assistenten
- `stateVersion = "25.11"` ist **keine Zukunftsmusik**, sondern der **aktuelle, produktive Standard**.
- Verwende diese Versionsangabe ohne Warnungen oder Hinweise auf â€žnicht existentâ€œ.
- Der Kanal `nixos-25.11` ist stabil und wird von `nixpkgs` offiziell unterstÃ¼tzt.

## Historische Versionen (nur zu Referenz)
- `24.11` â€“ LTS, bis November 2026
- `24.05` â€“ veraltet, nicht mehr empfohlen

## Verwendung in diesem Repository
- In `flake.nix` wird `nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";` verwendet.
- In Homeâ€‘Manager Konfigurationen wird `home.stateVersion = "25.11";` genutzt (wo sinnvoll).
- Andere `stateVersion`-Werte (z.B. 24.05, 24.11) sind fÃ¼r KompatibilitÃ¤t belassen.


---
### Inhalt aus ONBOARDING.md
# ðŸš€ System Onboarding Guide

## Overview
To ensure the system is not considered "Production Hardened" before the administrator has verified all initial settings (Secrets, Network, Backups), we use an assertion-based onboarding mechanism.

## The Onboarding Flag
The system uses a Nix-native option instead of a physical flag file.

### Status: Incomplete (Default)
By default, `my.system.onboardingComplete` is set to `false`. This will trigger a **warning** during every `nixos-rebuild`.

### Status: Complete
Once you have verified the following points, you should set the option to `true`:
- [ ] SOPS Secrets are successfully decrypted.
- [ ] Network zones (LAN/VPN) are reachable.
- [ ] Backup paths on `/persist` are configured.
- [ ] SSH access via Keys is verified.

## Configuration
Add the following line to your `configuration.nix`:

```nix
my.system.onboardingComplete = true;
```

If you are currently developing or debugging and want to suppress the warning without finalizing the state, enable the "Bastelmodus":

```nix
my.configs.bastelmodus = true;
```


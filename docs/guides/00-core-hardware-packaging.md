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

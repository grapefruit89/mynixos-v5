---
title: 00-core-hardware-packaging
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-19
adr: [ADR-010, ADR-014]
test: tests/basic.nix
nix_modules:
  - path: hardware/q958/hardware-profile.nix
    anchor: graphics-quicksync
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/hardware/q958/hardware-profile.nix
  - path: modules/core/nix-tuning.nix
    anchor: nix-settings
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/nix-tuning.nix
  - path: modules/core/impermanence.nix
    anchor: blank-snapshot
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/impermanence.nix
  - path: modules/core/lib-helpers.nix
    anchor: mkHardenedService
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/lib-helpers.nix
  - path: modules/security/onboarding.nix
    anchor: onboarding-complete
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/security/onboarding.nix
  - path: flake.nix
    anchor: nixpkgs-version
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/flake.nix
---

# Cluster 00: Core, Hardware & Packaging

Dieses Dokument bündelt alle Entscheidungen und Konfigurationen zur physikalischen Schicht, dem Basissystem und den Packaging-Standards. Es dient als "Knowledge Cell" für den Fujitsu Q958 Tower.

---

## 🚀 Hardware Acceleration & iGPU (QuickSync)

Für den Fujitsu Q958 (Intel UHD 630) ist QuickSync der "Heilige Gral". Wir erreichen 4K-Transcoding bei minimalem Stromverbrauch (~35W).

### 🏛️ 1. Die Treiber-Wahl (Layer 00-core)
Für den i3-9100 (Coffee Lake) ist der `intel-media-driver` (iHD) zwingend. Die Konfiguration erfolgt in `hardware/q958/hardware-profile.nix`.

### 🛠️ Konfiguration
```nix
hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];
};
```

### 🛡️ 2. Dienst-Berechtigungen (Layer 40-media)
Dienste, die auf die iGPU zugreifen (z.B. Jellyfin), müssen in der Gruppe `render` und `video` sein. Dies wird automatisch über die `mkService` Factory geregelt.

---

## 🧹 Blank Snapshot Persistence ("Erase your darlings")

Basierend auf den Patterns von Misterio77 führen wir die System-Hygiene auf das nächste Level.

### 🏛️ Das Prinzip
Das gesamte Root-Dateisystem (`/`) wird bei jedem Bootvorgang physisch durch einen leeren Snapshot ersetzt. Dies wird in `modules/core/impermanence.nix` gesteuert.

### 🛠️ Konfiguration
```nix
fileSystems."/" = {
  device = "none";
  fsType = "tmpfs";
  options = [ "defaults" "size=4G" "mode=755" ];
};
```

---

## ✂️ Nix DRY Refactoring (mkService Factory)

In mynixos folgen wir dem DRY-Prinzip. Wir nutzen eine zentrale Hilfsfunktion in `modules/core/lib-helpers.nix`.

### 🏆 Die hocheffiziente Service-Factory
Die Funktion `mkService` abstrahiert:
- Systemd Hardening (PrivateDevices, ProtectSystem)
- Impermanence Integration
- Ingress-Registrierung (Caddy)

### 🛠️ Beispiel
```nix
myLib.mkService {
  inherit config name;
  description = "Example Service";
  port = 1234;
  useSSO = true;
};
```

---

## 🏭 Industrial Automation (numtide Patterns)

Wir nutzen industrielle Werkzeuge für Konsistenz und Performance.

- **Unified Formatting (`treefmt`):** Konsistenter Code-Style.
- **Build Optimization (`nix-filter`):** Schlanke Build-Kontexte für schnellere Evaluation.

---

## ⚙️ Nixpkgs Engine & Versioning

Wir nutzen den aktuellen stabilen Kanal für maximale Sicherheit.

### 🗓️ Stand: Mai 2026
- **Version:** `nixos-25.11` (Stable)
- **Flake Input:** `nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";` (anchor: nixpkgs-version)

---

## 🚀 System Onboarding

Um sicherzustellen, dass das System erst nach vollständiger Prüfung als "Production Hardened" gilt, nutzen wir einen Onboarding-Flag in `modules/security/onboarding.nix`.

### Status setzen
Setze in deiner Konfiguration:
```nix
my.system.onboardingComplete = true; # anchor: onboarding-complete
```

---

## ✅ Verifizierung

```bash
# 1. Prüfe Intel QuickSync Treiber
intel_gpu_top -s 1 # Erwartet UHD Graphics 630 Sichtbarkeit

# 2. Prüfe Nix-Einstellungen
nix show-config | grep "max-jobs = 0"
# Positiv-Test: Optimierung aktiv
nix show-config | grep "auto-optimise-store = true"

# 3. Prüfe Impermanence (ob Root auf tmpfs)
findmnt / | grep "tmpfs"
# Negativ-Test: / darf NICHT auf der SSD liegen
! findmnt / | grep "ext4\|xfs"

# 4. Prüfe Onboarding Status
nix eval .#nixosConfigurations.nixhome.config.my.system.onboardingComplete | grep "true"
```

---

## 🔗 Quellen & Verweise

### Externe Repositories (NixOS-Native)
- [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs) - Offizielle Paketquelle & Module
- [nix-community/impermanence](https://github.com/nix-community/impermanence) - Framework für zustandslose Systeme
- [numtide/srvos](https://github.com/numtide/srvos) - Server-Optimierungsvorlagen
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config) - Architektur-Referenz

### Context7 Observability
<!-- context7: nixpkgs/nixos/modules/hardware/video/intel.nix -->
<!-- context7: nixpkgs/nixos/modules/services/misc/impermanence.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/hardware/q958/hardware-profile.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/impermanence.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/lib-helpers.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/hardware/q958/hardware-profile.nix -->
<!-- mcp: nixos:repo_v5/modules/core/nix-tuning.nix -->
<!-- mcp: nixos:repo_v5/modules/core/impermanence.nix -->
<!-- mcp: nixos:repo_v5/modules/core/lib-helpers.nix -->

---
*Status: Core Hardened | Letzte Aktualisierung: 19. Mai 2026*

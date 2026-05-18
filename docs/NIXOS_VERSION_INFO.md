# NixOS Version & Channel Information

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

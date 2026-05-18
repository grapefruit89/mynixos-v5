# Determinate Systems Tools (für NixHome)

Diese Dokumentation fasst die relevanten Tools von Determinate Systems zusammen, die in der NixHome CI oder optional genutzt werden können.

## Nix Installer (GitHub Actions)
Wir verwenden `determinate-systems/nix-installer-action` in unserer CI (`.github/workflows/validate.yml`), um Nix auf dem GitHub-Runner zu installieren.  
Die manuelle Installation auf dem Host ist nicht nötig – NixOS wird separat gemanagt.

## Magic Nix Cache (optional)
Kann die CI beschleunigen, indem es Build-Artefakte zwischen verschiedenen Runs teilt.  
**Aktivierung:** Füge nach dem Nix-Installer folgende Zeile hinzu:
```yaml
- uses: DeterminateSystems/magic-nix-cache-action@main
```
Aktuell ist der Cache nicht aktiviert, könnte aber bei langsamen Workflows helfen.

## flake-checker (optional)
Prüft die `flake.lock` auf bekannte Sicherheitslücken (CVEs) und veraltete Inputs.  
Kann manuell ausgeführt werden:
```bash
nix run github:DeterminateSystems/flake-checker
```
Oder als systemd-Timer auf dem Host (nicht aktiv).

## Nicht verwendete Enterprise-Features
- **FlakeHub** (wir beziehen `nixpkgs` direkt von GitHub)
- **Private Flakes / Secure Packages** (nicht benötigt)
- **SBOMs / Nixd** (Overkill für Homelab)

Diese Dokumentation ersetzt die älteren, verstreuten Notizen zu Determinate Tools.

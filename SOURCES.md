# Zero-Trust Provenance (v7.1)

Dieses Dokument dient der Rückverfolgbarkeit (Provenance) aller Konzepte, Entwurfsmuster und Code-Fragmente, die innerhalb dieses Repositories (`repo_v5`) verwendet werden. Im Einklang mit der "Zero-Trust"-Philosophie des Projekts werden diese Quellen als Inspiration und Referenz genutzt, ohne jedoch externe Abhängigkeiten (wie Flake-Inputs) direkt in die produktive Laufzeitumgebung zu importieren. Dies gewährleistet maximale Transparenz, Auditierbarkeit und Unabhängigkeit.

| Repository / Quelle | Extrahiertes Konzept / "Low-Hanging Fruit" | Implementiert in (Datei/Modul) | Anmerkung / Begründung |
| :--- | :--- | :--- | :--- |
| [Misterio77/nix-config](https://github.com/Misterio77/nix-config) | Systemd-Härtungen, modulare Struktur, Kernel-Sysctls | `modules/core/lib-helpers.nix`, `modules/core/kernel-hardening.nix` | Grundlage der v7.0 Strict Baseline |
| [vimjoyer/nixconf](https://github.com/vimjoyer/nixconf) | Kernel-Boot-Parameter (`init_on_alloc`, `slab_nomerge`), `mergeAttrsList` | `modules/core/kernel-hardening.nix`, `modules/core/lib-helpers.nix` | Fortgeschrittene Kernel-Härtung |
| [andersonjoseph/jailed-agents](https://github.com/andersonjoseph/jailed-agents) | `PrivateUsers`, `network = "none"` Policy | `modules/core/lib-helpers.nix` (mkService) | Namespace-Sandbox für Dienste |
| [giomf/NixoScope](https://github.com/giomf/NixoScope) | Modul-Abhängigkeitsvisualisierung (Python-Tool) | `scripts/audit-module-graph.sh` | Externes Tool, kein Import |
| [saylesss88/nix-book](https://github.com/saylesss88/nix-book) | `systemd-analyze security`, `linux-hardened` Kernel | `scripts/audit-systemd-security.sh`, `kernel-hardening.nix` | Bestätigung und Inspiration |
| [denful/dendrix](https://github.com/denful/dendrix) / [mightyiam/dendritic](https://github.com/mightyiam/dendritic) | Dendritisches Muster (rekursive Imports) | `modules/core/lib-helpers.nix` (`recursiveImportDir`) | Implementiert ohne flake-parts |
| [Mic92/sops-nix](https://github.com/Mic92/sops-nix) | Zero-Trust Secrets Pattern (Konzept) | `modules/security/zero-trust-secrets.nix`, `scripts/secrets-decryptor.sh` | Nur Konzept, eigene Implementierung |
| [kiriwalawren/nixflix](https://github.com/kiriwalawren/nixflix) | `PrivateNetwork = true`, `readOnlyPaths` für Media | `modules/apps/service-media-jellyfin.nix`, `lib-helpers.nix` | Medien-Stack Isolation |
| [nix-community/awesome-nix](https://github.com/nix-community/awesome-nix) | Entwicklungstools: `statix`, `deadnix`, `nixpkgs-fmt` | `scripts/audit-code-quality.sh` | Transiente Nutzung via `nix-shell -p` |

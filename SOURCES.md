# Zero-Trust Provenance (v7.1)

Dieses Dokument dient der Rückverfolgbarkeit (Provenance) aller Konzepte, Entwurfsmuster und Code-Fragmente, die innerhalb dieses Repositories (`repo_v5`) verwendet werden. Im Einklang mit der "Zero-Trust"-Philosophie des Projekts werden diese Quellen als Inspiration und Referenz genutzt, ohne jedoch externe Abhängigkeiten (wie Flake-Inputs) direkt in die produktive Laufzeitumgebung zu importieren. Dies gewährleistet maximale Transparenz, Auditierbarkeit und Unabhängigkeit.

| Repository / Quelle | Extrahiertes Konzept / "Low-Hanging Fruit" | Implementiert in (Datei/Modul) | Anmerkung / Begründung |
| :--- | :--- | :--- | :--- |
| [Misterio77/nix-config](https://github.com/Misterio77/nix-config) | Systemd-Härtungen, modulare Struktur, Kernel-Sysctls | `modules/core/lib-helpers.nix`, `modules/core/kernel-hardening.nix` | Grundlage der v7.0 Baseline |
| [vimjoyer/nixconf](https://github.com/vimjoyer/nixconf) | Kernel-Boot-Parameter (`init_on_alloc`, `slab_nomerge`), `mergeAttrsList` | `modules/core/kernel-hardening.nix`, `modules/core/lib-helpers.nix` | Fortgeschrittene Kernel-Härtung |
| [andersonjoseph/jailed-agents](https://github.com/andersonjoseph/jailed-agents) | `PrivateUsers`, `network = "none"` Policy | `modules/core/lib-helpers.nix` (mkService) | Namespace-Sandbox für Dienste |
| [giomf/NixoScope](https://github.com/giomf/NixoScope) | Modul-Abhängigkeitsvisualisierung (Python-Tool) | `scripts/audit-module-graph.sh` | Externes Tool, kein Import |
| [saylesss88/nix-book](https://github.com/saylesss88/nix-book) | `systemd-analyze security`, `linux-hardened` Kernel | `scripts/audit-systemd-security.sh`, `kernel-hardening.nix` | Bestätigung und Inspiration |
| [denful/dendrix](https://github.com/denful/dendrix) / [mightyiam/dendritic](https://github.com/mightyiam/dendritic) | Dendritisches Muster (rekursive Imports) | `modules/core/lib-helpers.nix` (`recursiveImportDir`) | Implementiert ohne flake-parts |
| [Mic92/sops-nix](https://github.com/Mic92/sops-nix) | Zero-Trust Secrets Pattern (Konzept) | `modules/security/zero-trust-secrets.nix`, `scripts/secrets-decryptor.sh` | Nur Konzept, eigene Implementierung |
| [kiriwalawren/nixflix](https://github.com/kiriwalawren/nixflix) | `PrivateNetwork = true`, `readOnlyPaths` für Media | `modules/apps/service-media-jellyfin.nix`, `lib-helpers.nix` | Medien-Stack Isolation |
| [nix-community/awesome-nix](https://github.com/nix-community/awesome-nix) | Entwicklungstools: `statix`, `deadnix`, `nixpkgs-fmt` | `scripts/audit-code-quality.sh` | Transiente Nutzung via `nix-shell -p` |
| [c00w/nix-mineral](https://github.com/c00w/nix-mineral) | gehärtetes Hardening, Sysctls, Protocol Blacklist | `modules/core/kernel-hardening.nix` | Kern der v7.1 Security |
| [nix-community/impermanence](https://github.com/nix-community/impermanence) | Stateless Root (Root-on-RAM) Patterns | `modules/core/impermanence.nix` | Fundament für Drift-Prävention |
| [pocket-id/pocket-id](https://github.com/pocket-id/pocket-id) | Passkey-focused OIDC Identity Provider | `modules/services/pocket-id.nix` | Zentraler SSO-Anker |
| [caddyserver/caddy](https://github.com/caddyserver/caddy) | Reverse Proxy, Forward-Auth, Auto-TLS | `modules/services/caddy.nix`, `services-spec.nix` | Ingress-Guard & SSL-Terminierung |
| [utensils/mcp-nixos](https://github.com/utensils/mcp-nixos) | Model Context Protocol for NixOS resources | `flake.nix` | KI-Infrastruktur-Schnittstelle |
| [nix-community/home-manager](https://github.com/nix-community/home-manager) | User Environment Management (declarative dotfiles) | `modules/core/home-manager.nix` | Pilot-System Konfiguration |
| [nix-community/vulnix](https://github.com/nix-community/vulnix) | CVE-Scanner für Nix/NixOS | `scripts/audit-cves.sh` | Sicherheits-Audit-Tooling |
| [0xERR0R/blocky](https://github.com/0xERR0R/blocky) | Declarative DNS-Filter & Local Resolver | `modules/services/blocky.nix` | Netzwerk-Ebene Ad-Blocking |
| [gethomepage/homepage](https://github.com/gethomepage/homepage) | Declarative Application Dashboard | `modules/apps/service-app-homepage.nix` | Zentrales Nutzer-Frontend |
| [nix-community/disko](https://github.com/nix-community/disko) | Declarative Partitioning & Formatting | `hardware/q958/PROVISIONING.md` | Logische Basis für Disk-Layouts |
| [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden) | Lightweight Bitwarden API Implementation | `modules/apps/service-app-vaultwarden.nix` | Passwort-Management-Backend |
| [paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) | Document Management System | `modules/apps/service-app-paperless.nix` | Dokumenten-Archivierung |
| [n8n-io/n8n](https://github.com/n8n-io/n8n) | Workflow Automation Platform | `modules/apps/service-app-n8n.nix` | Automatisierungs-Engine |
| [conduit-org/conduit](https://github.com/conduit-org/conduit) | Lightweight Matrix Homeserver in Rust | `modules/apps/service-app-matrix-conduit.nix` | Dezentrale Kommunikation |
| [recyclarr/recyclarr](https://github.com/recyclarr/recyclarr) | Declarative Arr-Stack Quality Profiles | `modules/apps/service-media-recyclarr.nix` | Media-Stack SRE Automation |

# 🚀 NixHome Project – LLM & Developer Guide (v7.1 Strict)

## 🤖 LLM Guiderails (MANDATORY)
**This project is time-sensitive and requires high precision regarding NixOS releases and library options.**

1. **Context7 Enforcement:** NEVER rely on internal training data for NixOS versions, EOL dates, or module options.
2. **Architecture Codex:** Strictly adhere to the mandates in `docs/ANTIPATTERN.md` (verbotene Technologien) und `docs/adr/` (Entscheidungen).
3. **Required Tooling:** Use `context7/query-docs` before proposing any changes to the flake or core modules.
4. **Core Library IDs:**
   - `nixpkgs`: `/nixos/nixpkgs`
   - `home-manager`: `/nix-community/home-manager`
   - `sops-nix`: `/mic92/sops-nix`

---

## 🗺️ Projekt-Map (Wo liegt was?)

| Pfad | Zweck | Wichtige Dateien |
|------|-------|------------------|
| `docs/guides/` | Operative Anleitungen („wie mache ich X?“) | `00-*.md`, `10-*.md`, …, `99-*.md` |
| `docs/adr/` | Architekturentscheidungen („warum haben wir Y gewählt?“) | `ADR-*.md`, `README.md` |
| `docs/` (Root) | Zentrale Referenzen | `ANTIPATTERN.md`, `LAYER_CONSOLIDATED.md`, `RISKS.md`, `CURRENT_STATUS.md` |
| `modules/core/` | Basis-Module (Hardening, SSH, Firewall, Secrets, …) | `kernel-hardening.nix`, `lib-helpers.nix`, `firewall.nix` |
| `modules/services/` | Infrastruktur-Dienste (Caddy, PostgreSQL, Vector, …) | `caddy.nix`, `postgresql.nix`, `vector.nix` |
| `modules/apps/` | Anwendungen (Jellyfin, Paperless, n8n, …) | `service-media-jellyfin.nix`, `service-app-paperless.nix` |
| `modules/security/` | Sicherheits-Policies (Binary-Only, No-Legacy, …) | `binary-only.nix`, `security-assertions.nix` |
| `profiles/` | Systemrollen (Kombination von Modulen) | `base-server.nix`, `media-beast.nix` |
| `users/` | Benutzerkonfigurationen (Home-Manager) | `moritz/`, `freund/` |
| `hardware/q958/` | Hardware-spezifische Profile | `hardware-profile.nix`, `PROVISIONING.md` |
| `secrets/` | SOPS-verschlüsselte Secrets (Beispiele, echte Dateien) | `infra.yaml.example`, `media.yaml.example` |
| `scripts/` | Hilfsskripte (Audit, NIXMETA-Validierung, Bootstrap) | `validate-nixmeta.sh`, `bootstrap-amp.sh` |

---

## 📦 NIXMETA-Header – Metadaten für Module

Jede Nix-Datei (`modules/**/*.nix`, `hardware/**/*.nix`, `profiles/*.nix`, `users/**/*.nix`) **sollte** einen NIXMETA-Header enthalten (beginnend mit `# ---NIXMETA` und endend mit `# ---ENDNIXMETA`). Dieser Header ist **maschinenlesbar** (JSON) und dient der Rückverfolgbarkeit (Traceability).

### Pflichtfelder (laut `docs/NIXMETA_SCHEMA.json`)

| Feld | Typ | Beispiel |
|------|-----|----------|
| `specVersion` | string, "2.0" | `"2.0"` |
| `id` | string (Pattern: `NIXH-XXX-...`) | `"NIXH-00-COR-024"` |
| `title` | string | `"Hardened nftables Firewall"` |
| `layer` | integer (0–99) | `0` |
| `category` | string | `"core/network"` |
| `lastReviewed` | date (YYYY-MM-DD) | `"2026-05-19"` |
| `reviewedBy` | string | `"Gemini"` |
| `status` | enum (draft/review/production/deprecated) | `"production"` |
| `complexity` | integer (1–5) | `3` |
| `description` | string (≥10 Zeichen) | `"Zero-Trust nftables configuration …"` |

### Optionale Felder (empfohlen)

| Feld | Zweck |
|------|-------|
| `tags` | Schlagwörter für Suche/Kategorisierung |
| `dependencies` | IDs anderer Module, von denen dieses abhängt |
| `provides` | Capabilities, die dieses Modul bereitstellt |
| `metrics` | Automatisch generierte Größen (sha256, Zeilen, etc.) |

### Wie LLMs die Header nutzen sollen

- **Lokalisierung:** Suche nach `# ---NIXMETA` in einer Datei, extrahiere den JSON-Block.
- **Traceability:** Wenn du ein Modul mit einer bestimmten `id` suchst, verwende `rg "id.*NIXH-00-COR-024" modules/`.
- **Verbindung zu Guides/ADRs:** Die `nix_modules`-Felder in Guides/ADRs referenzieren Pfade und Anker (z. B. `anchor: kernel-hardening`). Suche im Modul nach `# anchor: kernel-hardening`, um die exakte Stelle zu finden.
- **Konsistenzprüfung:** Ein LLM kann vor einer Änderung prüfen, ob die Metadaten noch aktuell sind (z. B. `lastReviewed` älter als 6 Monate → Warnung).

---

## 🔗 Verlinkungen zwischen ADRs, Guides und Modulen

- **ADR** → **Modul:** Im Frontmatter der ADR unter `nix_modules:` (Pfad + optional `anchor`).
- **Guide** → **Modul:** Im Frontmatter des Guides unter `nix_modules:` (Pfad + `anchor` + `github_url`).
- **Guide** → **ADR:** Im Frontmatter des Guides unter `adr: [ADR-xxx, ...]`.
- **Modul** → **Guide/ADR:** Über die `# anchor:`-Kommentare im Code. Suche nach dem Anchor-Namen in `docs/guides/` and `docs/adr/`.

**Beispiel für einen Anchor im Modul:**
```nix
# 🛡️ SSH HARDENING (anchor: ssh-hardening)
services.openssh = {
  ...
};
```

Im Guide steht dann:
```yaml
nix_modules:
  - path: modules/core/ssh.nix
    anchor: ssh-hardening
```

Ein LLM kann mit `rg "anchor: ssh-hardening" modules/ docs/` alle Verweise finden.

---

## 🤖 Empfohlener Arbeitsablauf für LLMs (z. B. Gemini, Claude)

1. **Kontext laden:** Lies `GEMINI.md` (diese Datei), dann `docs/CURRENT_STATUS.md`.
2. **Projekt-Map verstehen:** Welche Ordner sind für die Aufgabe relevant?
3. **Metadaten nutzen:** Suche nach Modulen mit `rg "# ---NIXMETA" modules/core/` oder nach spezifischen IDs.
4. **Änderungen idempotent durchführen:** Vor jeder Änderung prüfen, ob das Ziel bereits erreicht ist.
5. **Konsistenz wahren:** Wenn du ein Modul änderst, prüfe, ob die zugehörigen ADRs/Guides aktualisiert werden müssen (Suche nach dem Anchor oder der Datei in `docs/`).

---

## 🛤️ Projekt-Status & Roadmap (SSoT)

**ALLE offenen Punkte und der aktuelle Fortschritt werden AUSSCHLIESSLICH hier verwaltet:**  
👉 `docs/CURRENT_STATUS.md`

*(Keine To-Do Listen direkt in dieser Datei pflegen!)*

# Metadaten-Standard für ADRs und Guides

Dieses Dokument definiert den verbindlichen Standard für die Metadaten (YAML-Frontmatter) aller Architektur-Dokumente im Projekt.

## Für ADRs (docs/adr/ADR-XXX-*.md)
Jede ADR MUSS mit folgendem YAML-Frontmatter beginnen:

```yaml
---
title: "Kurzer, aussagekräftiger Titel"
status: (PROPOSED|ACCEPTED|SUPERSEDED|DEPRECATED)
date: YYYY-MM-DD
domain: (00-99)
related:
  guide: docs/guides/XX-name.md  # Pfad relativ zum Repo-Root
  modules: modules/XX-name/       # Ordner, falls vorhanden
---
```

## Für Guides (docs/guides/XX-name.md)
Jeder Guide MUSS mit folgendem YAML-Frontmatter beginnen:

```yaml
---
title: "Titel"
domain: (00-99)
related:
  adr: docs/adr/ADR-XXX-*.md
  modules: modules/XX-name/
---
```

## Pflichtfelder für beide
- `title` – immer vorhanden.
- `domain` – immer vorhanden (zweistellige Zahl).
- `related` – mindestens eine Verknüpfung (adr oder guide oder modules).

## Verbotene Muster
- Fehlende Verknüpfungen zwischen ADR und Guide derselben Domain.
- Unterschiedliche Domänen-Angaben in Dateiname und Frontmatter.
- Veraltete Pfade in den `related`-Links.

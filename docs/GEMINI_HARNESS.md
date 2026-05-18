# Gemini CLI Harness — Distiller Project
> `conductor/GEMINI_HARNESS.md` — Version 1.0 — Mo Ritschel

---

## Einleitung: Wie die drei Artikel in dieses Artefakt eingeflossen sind

| Quelle | Kernkonzept | Umsetzung in diesem Artefakt |
|---|---|---|
| **Harness.io – Effective Prompting** | Ein Prompt = eine Aufgabe; klare Verben; spezifische Pfade; iteratives Verfeinern nach jedem Schritt | Jede Prompt-Vorlage beginnt mit einem Aktionsverb, referenziert absolute Pfade und schließt mit einer verpflichtenden Zusammenfassung (Context Reset). |
| **Reddit – Brain vs. Body** | LLM = Brain (Inferenz, Entscheidung); deterministischer Ablauf = Body (Zustandsmaschine, DAG, Dead-Letter-Queue) | Die Checkliste modelliert den Body: feste Abhängigkeiten, explizite Zustandsübergänge, FAILED_TASKS.md als DLQ. Gemini entscheidet nur innerhalb klar abgegrenzter Knoten. |
| **Anthropic – Harness Design** | Context Resets nach jedem Schritt; strukturierte Artefakte speichern Zustand; Clean Slate verhindert Drift | Das Zustands-Schema (`GEMINI_SESSION_STATE.md`) ist das persistente Gedächtnis zwischen Sitzungen. Gemini schreibt es nach jedem Schritt fort, nicht erst am Ende. |

> **Betriebsprinzip:** Gemini ist der Brain, dieses Harness ist der Body. Gemini trifft Entscheidungen, das Harness steuert den Fluss, speichert den Zustand und fängt Fehler auf.

---

## Teil 1 — Prompt-Vorlagen für Gemini CLI

> **Verwendung:** Kopiere die gewünschte Vorlage in Gemini CLI. Ersetze `[PLATZHALTER]` vor dem Absenden. Nach jedem nummerierten Schritt wartest du auf Geminis Zusammenfassung, bevor du fortsetzt.

---

### Vorlage A — Initialisierung einer neuen Sitzung

```
KONTEXT: Ich arbeite am Distiller-Projekt auf Windows.
Aktive Dateiliste:      C:\Users\morit\Documents\distiller_project\active_files.txt
Archivierbare Dateien:  C:\Users\morit\Documents\distiller_project\archivable_files.txt
Haupt-Codebasis:        C:\Users\morit\Documents\distiller_project\repo_v5\
Sitzungsstatus:         C:\Users\morit\Documents\distiller_project\repo_v5\docs\GEMINI_SESSION_STATE.md

AUFGABE (Schritt 1): Lese `repo_v5\docs\GEMINI_SESSION_STATE.md` vollständig.

Berichte nach Schritt 1:
- Was ist der aktuelle `current_task`?
- Welche `completed_tasks` existieren bereits?
- Gibt es `failed_tasks` in der Dead-Letter-Queue?
- Was sind die `next_steps`?

Warte auf meine Bestätigung, bevor du fortfährst.
```

---

### Vorlage B — Analyse der aktiven Dateiliste

```
KONTEXT-ANKERPUNKTE:
- active_files.txt:  C:\Users\morit\Documents\distiller_project\active_files.txt (489 Pfade)
- Ziel-Repo:         C:\Users\morit\Documents\distiller_project\repo_v5\

AUFGABE (Schritt 1): Lade `C:\Users\morit\Documents\distiller_project\active_files.txt`.

AUFGABE (Schritt 2): Gruppiere die 489 Pfade nach ihrem übergeordneten Ordner
  (modules/, profiles/, scripts/, users/, docs/, hardware/, conductor/).

AUFGABE (Schritt 3): Identifiziere Pfade, die in mehr als einem Unterordner
  redundant vorkommen (z.B. docs/obsidian_release/ vs. repo_v5/docs/).

AUFGABE (Schritt 4): Erstelle eine priorisierte Liste der Top-5-Redundanzcluster,
  sortiert nach Anzahl betroffener Dateien (absteigend).

Nach jedem Schritt: Gib eine einzeilige Zusammenfassung aus im Format:
  ✅ Schritt [N] abgeschlossen — [Ergebnis in einem Satz]

Aktualisiere danach `repo_v5\docs\GEMINI_SESSION_STATE.md` (Feld: `completed_tasks`).
```

---

### Vorlage C — Konsolidierungsplan für Dokumentations-Duplikate

```
KONTEXT:
- Ältere Docs:   C:\Users\morit\Documents\distiller_project\docs\obsidian_release\
- Neuere Docs:   C:\Users\morit\Documents\distiller_project\repo_v5\docs\layers\
                 C:\Users\morit\Documents\distiller_project\repo_v5\docs\adr\
                 C:\Users\morit\Documents\distiller_project\repo_v5\docs\guides\
- Archivliste:   C:\Users\morit\Documents\distiller_project\archivable_files.txt

AUFGABE (Schritt 1): Prüfe, welche Dateinamen in `docs\obsidian_release\`
  auch in `repo_v5\docs\` existieren (Namensabgleich, kein Inhalt).

AUFGABE (Schritt 2): Klassifiziere jeden Treffer in eine von drei Kategorien:
  [SUPERSEDED]   — repo_v5-Version ist aktueller (nach Datum oder Versionsnummer)
  [DIVERGED]     — beide Versionen haben eigenständige Inhalte
  [IDENTICAL]    — Inhalt ist identisch, eine Kopie ist redundant

AUFGABE (Schritt 3): Erstelle einen Konsolidierungsplan als Tabelle:
  | Quelldatei | Zieldatei | Kategorie | Empfohlene Aktion |
  Empfohlene Aktionen: `Archivieren`, `Zusammenführen`, `Behalten`

AUFGABE (Schritt 4): Schreibe alle Dateien mit Aktion `Archivieren` in
  `archivable_files.txt` (append, keine Duplikate).

Nach jedem Schritt: ✅ Schritt [N] abgeschlossen — [Ergebnis in einem Satz]
Trage Fortschritt in `repo_v5\docs\GEMINI_SESSION_STATE.md` ein.
```

---

### Vorlage D — Fehler-Eskalation (Dead-Letter-Queue)

```
KONTEXT: Ein vorheriger Task ist fehlgeschlagen.
Fehlerstatus: repo_v5\docs\FAILED_TASKS.md
Sitzungsstatus: repo_v5\docs\GEMINI_SESSION_STATE.md

AUFGABE (Schritt 1): Lese `repo_v5\docs\FAILED_TASKS.md` vollständig.

AUFGABE (Schritt 2): Identifiziere den jüngsten Eintrag (nach `timestamp`).

AUFGABE (Schritt 3): Analysiere die `error_reason` und schlage genau
  eine Korrekturmaßnahme vor. Format:
  - Task-ID: [ID]
  - Fehlerursache: [Ursache]
  - Korrektur: [konkreter Schritt, beginnend mit Verb]
  - Vorbedingung für Wiederholung: [was muss zuerst geprüft werden]

AUFGABE (Schritt 4): Aktualisiere `repo_v5\docs\GEMINI_SESSION_STATE.md`:
  - Setze `current_task` auf die korrigierte Task-ID
  - Setze Status auf `pending` (Wiederholung)

Warte auf meine explizite Freigabe, bevor der Task neu gestartet wird.
```

---

## Teil 2 — Deterministische Checkliste für Gemini CLI

> **Zweck:** Dieser Body-Ablauf läuft unabhängig vom Inhalt der Gemini-Antworten.
> Gemini darf nur innerhalb eines Knotens entscheiden. Der Fluss zwischen Knoten ist hier festgelegt.

---

### 2.1 — DAG: Aufgaben-Abhängigkeiten

```
[START]
   │
   ▼
[T-01] Sitzungsstatus laden
   │    Pfad: repo_v5\docs\GEMINI_SESSION_STATE.md
   │    Abhängigkeit: keine
   │
   ▼
[T-02] active_files.txt analysieren
   │    Pfad: distiller_project\active_files.txt
   │    Abhängigkeit: T-01 ∈ done
   │
   ▼
[T-03] Duplikate identifizieren
   │    Pfad: docs\obsidian_release\ ↔ repo_v5\docs\
   │    Abhängigkeit: T-02 ∈ done
   │
   ├──► [T-04a] Konsolidierungsplan erstellen
   │           Abhängigkeit: T-03 ∈ done
   │
   └──► [T-04b] archivable_files.txt aktualisieren
                Abhängigkeit: T-04a ∈ done
                Pfad: distiller_project\archivable_files.txt

[T-05] GEMINI_SESSION_STATE.md fortschreiben
        Abhängigkeit: T-04a ∈ done UND T-04b ∈ done

[END] oder [FAILED] → DLQ
```

---

### 2.2 — Zustandsübergänge

| Zustand | Bedeutung | Erlaubter Folgezustand |
|---|---|---|
| `pending` | Task wartet auf Ausführung | `in_progress` |
| `in_progress` | Gemini bearbeitet den Task gerade | `done`, `failed` |
| `done` | Task erfolgreich abgeschlossen | `pending` (Folgetask) |
| `failed` | Task fehlgeschlagen, Ursache protokolliert | `pending` (nach Korrektur) |
| `skipped` | Task übersprungen (bewusste Entscheidung) | `pending` (Folgetask) |

> **Regel:** Ein Folge-Task darf nur gestartet werden, wenn alle Vorgänger `done` oder `skipped` sind. Niemals `in_progress` → nächster Task starten.

---

### 2.3 — Vorbedingungs-Checkliste (vor jedem Task)

Vor dem Start eines jeden Tasks prüft Gemini diese Liste vollständig:

- [ ] **Existenzprüfung:** Existiert die Eingabedatei/der Eingabepfad?
  - Wenn nein → sofort `failed` setzen, Fehler in `repo_v5\docs\FAILED_TASKS.md` eintragen.
- [ ] **Sperrstatus:** Ist die Zieldatei gerade durch einen anderen Prozess gesperrt?
  - Wenn ja → Task in `pending` belassen, Hinweis ausgeben.
- [ ] **Duplikat-Schutz:** Würde der Task einen bereits `done` Schritt wiederholen?
  - Wenn ja → Status auf `skipped` setzen, Grund protokollieren.
- [ ] **Abhängigkeiten:** Sind alle Vorgänger-Tasks `done` oder `skipped`?
  - Wenn nein → Ausführung verweigern, Meldung ausgeben.
- [ ] **Schreib-Bestätigung:** Würde der Task eine bestehende Datei überschreiben?
  - Wenn ja → explizite Benutzerbestätigung einholen (kein Auto-Overwrite).

---

### 2.4 — Dead-Letter-Queue (DLQ) — Protokollformat

Datei: `C:\Users\morit\Documents\distiller_project\repo_v5\docs\FAILED_TASKS.md`

Jeder fehlgeschlagene Task wird mit diesem Block **append** eingetragen:

```markdown
## FAILED: [Task-ID]
- **timestamp:**     [YYYY-MM-DD HH:MM]
- **task_name:**     [Kurzbeschreibung]
- **input_path:**    [absoluter Pfad der Eingabe]
- **output_path:**   [absoluter Pfad des geplanten Outputs]
- **error_reason:**  [genaue Fehlermeldung oder Beschreibung]
- **attempted_fix:** [was versucht wurde, bevor failed gesetzt wurde]
- **retry_ready:**   false
- **notes:**         [optionale Anmerkungen]
---
```

> Kein Task wird aus der DLQ gelöscht. `retry_ready: true` signalisiert, dass der Task
> wieder in `pending` gesetzt werden darf — nach expliziter manueller Prüfung.

---

## Teil 3 — Zustands-Tracking-Schema

Datei: `C:\Users\morit\Documents\distiller_project\repo_v5\docs\GEMINI_SESSION_STATE.md`

> **Schreibregeln:**
> 1. Gemini schreibt dieses Dokument **nach jedem Schritt** fort, nicht nur am Ende.
> 2. Niemals löschen — nur Felder aktualisieren oder Einträge hinzufügen.
> 3. Das Dokument ist der einzige persistente Kontext zwischen Sitzungen (Context Reset Boundary).

---

```markdown
# GEMINI SESSION STATE
> Zuletzt aktualisiert: [YYYY-MM-DD HH:MM] von Gemini CLI

---

## Aktuelle Sitzung

| Feld | Wert |
|---|---|
| `session_id` | [z.B. 2025-05-17-001] |
| `started_at` | [YYYY-MM-DD HH:MM] |
| `current_task` | [Task-ID und Kurzbeschreibung, z.B. T-03: Duplikate identifizieren] |
| `current_status` | [pending / in_progress / done / failed] |
| `context_resets` | [Anzahl der bisherigen Context Resets in dieser Sitzung] |

---

## Abgeschlossene Tasks

| Task-ID | Beschreibung | Abgeschlossen am | Ausgabe-Pfad |
|---|---|---|---|
| T-01 | Sitzungsstatus laden | [Datum] | repo_v5\docs\GEMINI_SESSION_STATE.md |
| T-02 | active_files.txt analysieren | [Datum] | — (nur Analyse) |
| ... | ... | ... | ... |

---

## Fehlgeschlagene Tasks (Dead-Letter-Queue Referenz)

| Task-ID | Beschreibung | Fehlgeschlagen am | DLQ-Eintrag |
|---|---|---|---|
| [ID] | [Beschreibung] | [Datum] | repo_v5\docs\FAILED_TASKS.md ## FAILED:[ID] |

---

## Nächste Schritte

> Geordnet nach Ausführungsreihenfolge. Abhängigkeiten sind im DAG (Teil 2.1) definiert.

1. [ ] **[Task-ID]** — [Kurzbeschreibung] — Abhängigkeit: [Vorgänger-Task]
2. [ ] **[Task-ID]** — [Kurzbeschreibung] — Abhängigkeit: [Vorgänger-Task]
3. [ ] **[Task-ID]** — [Kurzbeschreibung] — Abhängigkeit: [Vorgänger-Task]

---

## Abhängigkeiten (aktueller Stand)

| Task | Vorgänger | Status der Vorgänger |
|---|---|---|
| T-03 | T-01, T-02 | [done / pending] |
| T-04a | T-03 | [done / pending] |
| T-04b | T-04a | [done / pending] |
| T-05 | T-04a, T-04b | [done / pending] |

---

## Offene Entscheidungen

> Punkte, bei denen Gemini auf manuelle Bestätigung wartet.

| Entscheidung | Kontext | Erstellt am | Status |
|---|---|---|---|
| [Beschreibung der Entscheidung] | [Warum wartet Gemini?] | [Datum] | awaiting_input |

---

## Projekt-Ankerpunkte (unveränderlich)

| Bezeichnung | Absoluter Pfad |
|---|---|
| Aktive Dateiliste | `C:\Users\morit\Documents\distiller_project\active_files.txt` |
| Archivierbare Dateien | `C:\Users\morit\Documents\distiller_project\archivable_files.txt` |
| Haupt-Codebasis | `C:\Users\morit\Documents\distiller_project\repo_v5\` |
| Ältere Docs | `C:\Users\morit\Documents\distiller_project\docs\obsidian_release\` |
| Conductor-Ordner | `C:\Users\morit\Documents\distiller_project\repo_v5\docs\` |
| DLQ | `C:\Users\morit\Documents\distiller_project\repo_v5\docs\FAILED_TASKS.md` |
| Dieses Dokument | `C:\Users\morit\Documents\distiller_project\repo_v5\docs\GEMINI_SESSION_STATE.md` |

---

## Notizen / Freitext

> Für alles, was nicht in die obigen Felder passt.
> Jede Notiz mit Datum und Quelle (Gemini / Mo) kennzeichnen.

- [YYYY-MM-DD] [Gemini/Mo]: [Notiz]
```

---

## Schnell-Referenz: Gemini CLI — Sitzungsstart

```
Schritt 0 (immer zuerst): Lies repo_v5\docs\GEMINI_SESSION_STATE.md.
Schritt 1:                 Berichte current_task und next_steps.
Schritt 2:                 Warte auf meine Freigabe für den nächsten Task.
Schritt N (immer zuletzt): Schreibe GEMINI_SESSION_STATE.md fort, bevor du antwortest.
```

> Dieses Harness ist der Body. Gemini ist der Brain. Der Brain entscheidet niemals über den Fluss — nur über den Inhalt innerhalb eines Knotens.

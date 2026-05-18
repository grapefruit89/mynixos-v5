---
title: ADR-014: Systemic Governance & Purity Mandate
status: [ACCEPTED]
category: architecture/decision
capabilities: [evaluation-performance, dependency-integrity, security-purity]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/core/architecture-rules.nix
  - path: modules/security/security-assertions.nix
sources: [Nixpkgs Maintainer Guide, Manifest v7.1]
---

# 🏛️ ADR-014: Systemic Governance

Dieses ADR definiert die Regeln für die langfristige Stabilität und Sicherheit von mynixos.

## 🚫 1. IFD-Verbot (No Import-From-Derivation)
IFD ist im gesamten `mynixos/` Baum untersagt, um die Evaluations-Performance zu garantieren.

## 🛠️ 2. Fix-at-Source (Anti-Override Policy)
Wir vermeiden `overrideAttrs` innerhalb der eigenen Module. Anpassungen geschehen über saubere Funktions-Abstraktionen.

## 🛡️ 3. No External Frameworks
Die Nutzung von `flake-parts` oder anderen externen Architektur-Frameworks ist untersagt, um die volle Kontrolle über den Dependency-Graph zu behalten.

## Umsetzung in Nix
Die Einhaltung wird durch die **Architecture Rule Engine** erzwungen:
- `modules/core/architecture-rules.nix` (Assertion gegen flake-parts).
- `modules/security/security-assertions.nix` (Struktur-Validierung).

## Verifizierung
```bash
# Prüfe auf unzulässige Frameworks im Flake
nix flake show --all-systems | grep "flake-parts"
# Erwartetes Ergebnis: Kein Treffer.
```
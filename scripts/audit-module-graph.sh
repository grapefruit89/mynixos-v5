#!/usr/bin/env bash
# ────────────────────────────────────────────────────────────────────────────────
# QUELLEN:
# - giomf/NixoScope (Modul-Abhängigkeitsvisualisierung)
# ────────────────────────────────────────────────────────────────────────────────
# Audit: Module Graph Visualization (NixoScope Pattern)
# Dieses Skript exportiert die Modul-Struktur für visuelle Audits.

# Sicherstellen, dass wir im Repo-Root sind
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# 1. Exportiere den Graphen deiner nixhome Konfiguration
# Wir nutzen .#nixosConfigurations.q958 für die Fujitsu-Hardware
echo "🔍 Exportiere Modul-Abhängigkeiten für nixhome (q958)..."
nix eval --json .#nixosConfigurations.q958.config.system.modulesTree > modules-graph.json

# 2. Hinweis zur Visualisierung
echo "✅ Export abgeschlossen: modules-graph.json"
echo "💡 Du kannst dieses JSON nun mit NixoScope (lokal) visualisieren:"
echo "   python path/to/nixoscope.py --input modules-graph.json --format mm > graph.mermaid"

# Secret Injection Guide

## Struktur
- `secrets/infra.yaml`: Enthält globale Secrets (Cloudflare, Backblaze, SOPS‑Keys, etc.)
- `secrets/media.yaml`: Enthält Media‑spezifische Secrets (API‑Keys für *arr‑Apps, SABnzbd, etc.)

## Vor dem ersten Rebuild
1. Kopiere die Beispiel‑Dateien:
   ```bash
   cp secrets/infra.yaml.example secrets/infra.yaml
   cp secrets/media.yaml.example secrets/media.yaml
   ```

2. Bearbeite beide Dateien und ersetze alle Platzhalter (z. B. CHANGE_ME, PLACEHOLDER).

3. Verschlüssele die Dateien mit SOPS:
   ```bash
   sops --encrypt --in-place secrets/infra.yaml
   sops --encrypt --in-place secrets/media.yaml
   ```

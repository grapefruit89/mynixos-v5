#!/usr/bin/env bash
# systemd-analyze security CI-Check für alle eigenen Dienste

set -euo pipefail

THRESHOLD="OK"   # "OK" oder besser (z.B. "SAFE")
FAILED=0

echo "🔍 Prüfe systemd Security Scores..."

# Ermittle alle Dienste, die nicht von systemd selbst stammen
# Passe den Filter ggf. an deine Namenskonvention an (z.B. Dienste die mit "media-" oder "arr-" beginnen)
SERVICES=$(systemctl list-unit-files --type=service | grep -E "^(media-|arr-|gatus|forgejo|vaultwarden)" | awk '{print $1}' || true)

for service in $SERVICES; do
  if systemctl is-active --quiet "$service"; then
    SCORE=$(systemd-analyze security "$service" 2>/dev/null | grep -E "^→ Overall exposure level:" | awk '{print $5}' || echo "UNKNOWN")
    if [[ "$SCORE" != "$THRESHOLD" ]] && [[ "$SCORE" != "SAFE" ]]; then
      echo "⚠️  $service hat Score $SCORE (sollte mindestens $THRESHOLD sein)"
      FAILED=1
    else
      echo "✅ $service: $SCORE"
    fi
  fi
done

if [ $FAILED -eq 1 ]; then
  echo "❌ Mindestens ein Dienst unterschreitet den Sicherheitsstandard."
  exit 1
else
  echo "🎉 Alle geprüften Dienste sind sicher (Score $THRESHOLD oder besser)."
  exit 0
fi

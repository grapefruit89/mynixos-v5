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
    # Robust parsing of the numeric score or exposure level
    SCORE_INFO=$(systemd-analyze security "$service" 2>/dev/null | grep -E "Overall exposure level:")
    SCORE=$(echo "$SCORE_INFO" | sed -n 's/.* \([0-9.]*\) .*/\1/p' | head -n 1)
    LEVEL=$(echo "$SCORE_INFO" | sed -n 's/.*→ \(.*\)/\1/p' | xargs)
    
    if [[ "$LEVEL" != "$THRESHOLD" ]] && [[ "$LEVEL" != "SAFE" ]]; then
      echo "⚠️  $service: Level=$LEVEL Score=$SCORE (Target: $THRESHOLD)"
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

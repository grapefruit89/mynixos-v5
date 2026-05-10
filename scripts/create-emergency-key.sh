#!/bin/bash
# 🚨 SEC-02: Emergency Age-Key Generation
# This key is the "Last Resort" for decrypting SOPS secrets if all other keys are lost.
# Path: /mnt/cache/secrets/emergency_age_key.txt (Tier B)

set -e

TARGET_PATH="/mnt/cache/secrets/emergency_age_key.txt"
TARGET_DIR=$(dirname "$TARGET_PATH")

echo "--- 🚨 GENERATING EMERGENCY AGE KEY (SEC-02) ---"

if [ -f "$TARGET_PATH" ]; then
    echo "⚠️  Emergency key already exists at $TARGET_PATH"
    echo "   If you want to regenerate it, delete the file first."
    exit 0
fi

# Ensure directory exists
mkdir -p "$TARGET_DIR"
chmod 700 "$TARGET_DIR"

# Generate key using age-keygen (assuming age is in PATH)
if command -v age-keygen >/dev/null 2>&1; then
    age-keygen -o "$TARGET_PATH"
    chmod 600 "$TARGET_PATH"
    echo "✅ Success: Emergency key created at $TARGET_PATH"
    echo "⚠️  WICHTIG: Drucke diese Datei aus und lege sie in einen physischen Tresor!"
    echo "   Öffentlicher Schlüssel:"
    grep "public key:" "$TARGET_PATH"
else
    echo "❌ Error: age-keygen not found. Please install 'age'."
    exit 1
fi

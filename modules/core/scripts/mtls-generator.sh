#!/bin/bash
# 🔐 NIXHOME mTLS Generator (Aviation-Grade CSR Edition)
# Erlaubt das Signieren von CSRs, damit Private Keys hardwaregebunden bleiben.

CA_DIR="/etc/nixos/secrets/mtls"
CA_KEY="$CA_DIR/ca.key"
CA_CRT="$CA_DIR/ca.crt"
OUTPUT_DIR="/var/www/landing-zone/certs"

mkdir -p "$OUTPUT_DIR"

if [ "$1" == "sign-csr" ]; then
    CLIENT_NAME=$2
    CSR_FILE=$3
    echo "Signiere CSR für $CLIENT_NAME..."
    openssl x509 -req -in "$CSR_FILE" -CA "$CA_CRT" -CAkey "$CA_KEY" -CAcreateserial \
        -out "$OUTPUT_DIR/$CLIENT_NAME.crt" -days 365 -sha256
    echo "Zertifikat erstellt: $OUTPUT_DIR/$CLIENT_NAME.crt"
else
    # Legacy Mode: Generiert Key + Cert (weniger sicher, da Key den Server berührt)
    CLIENT_NAME=$1
    echo "Generiere Legacy-Zertifikat für $CLIENT_NAME..."
    openssl genrsa -out "$OUTPUT_DIR/$CLIENT_NAME.key" 4096
    openssl req -new -key "$OUTPUT_DIR/$CLIENT_NAME.key" -out "$OUTPUT_DIR/$CLIENT_NAME.csr" \
        -subj "/CN=$CLIENT_NAME"
    openssl x509 -req -in "$OUTPUT_DIR/$CLIENT_NAME.csr" -CA "$CA_CRT" -CAkey "$CA_KEY" \
        -CAcreateserial -out "$OUTPUT_DIR/$CLIENT_NAME.crt" -days 365 -sha256
    echo "Fertig. Download unter: https://nix.m7c5.de/certs/$CLIENT_NAME.crt"
fi

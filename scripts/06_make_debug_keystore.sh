#!/usr/bin/env bash
set -euo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
cd "$REPO/apps/web/android/app"
mkdir -p keystore
keytool -genkey -v -keystore keystore/release.jks -alias release -keyalg RSA -keysize 2048 -validity 36500 -storepass password -keypass password -dname "CN=Consultas,O=Consultas,L=PT,S=PT,C=PT"
echo "Keystore criada (debug)."

#!/usr/bin/env bash
set -euo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
unzip -o "$KIT_DIR/gestao-consultas-bundle-v1.zip" -d /tmp/gc-bundle >/dev/null
unzip -o "$KIT_DIR/android-optimizations-v19.zip" -d /tmp/gc-android >/dev/null
rsync -a --ignore-existing /tmp/gc-bundle/docker-compose.yml "$REPO"/
mkdir -p "$REPO/env"; rsync -a --ignore-existing /tmp/gc-bundle/env/ "$REPO/env/"
rsync -a --ignore-existing /tmp/gc-bundle/patch/ "$REPO/"
mkdir -p "$REPO/apps/web/android"; rsync -a --ignore-existing /tmp/gc-android/patch/ "$REPO/apps/web/android/"
echo "OK — bundle + android aplicados (sem sobrescrever ficheiros existentes)."

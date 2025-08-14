#!/usr/bin/env bash
set -euo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
cd "$REPO" && docker compose up -d && echo "Infra DEV a correr (Postgres/Redis/Maildev)."

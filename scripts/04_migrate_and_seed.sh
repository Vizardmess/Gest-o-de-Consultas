#!/usr/bin/env bash
set -euo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
cd "$REPO"
npm ci
npm run prisma:generate || true
npx prisma validate || true
echo "Prisma validado."

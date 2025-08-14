#!/usr/bin/env bash
set -euo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
cd "$REPO"
mkdir -p apps/api apps/web
cp -n env/api.env.example apps/api/.env || true
cp -n env/web.env.example apps/web/.env.local || true
DATA_KEY=$(openssl rand -base64 32); JWT=$(openssl rand -base64 32); JWT_REFRESH=$(openssl rand -base64 32)
sed -i.bak "s|^DATA_KEY_CURRENT=.*|DATA_KEY_CURRENT=$DATA_KEY|" apps/api/.env || true
sed -i.bak "s|^JWT_SECRET=.*|JWT_SECRET=$JWT|" apps/api/.env || true
sed -i.bak "s|^JWT_REFRESH_SECRET=.*|JWT_REFRESH_SECRET=$JWT_REFRESH|" apps/api/.env || true
echo "Env prontos."

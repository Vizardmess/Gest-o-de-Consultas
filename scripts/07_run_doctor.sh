#!/usr/bin/env bash
set -Eeuo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
cd "$REPO"
echo "==> Project Doctor: reconstrói e valida"
FAILED=0
step(){ echo; echo "🔎 $1"; }
err(){ echo "❌ $1"; FAILED=1; }

step "Node & npm"; node -v || err "Node em falta"; npm -v || err "npm em falta"
step "Instalação deps"; npm ci || err "npm ci falhou"
step "Prisma"; npm run prisma:generate || true; npx prisma validate || err "prisma validate falhou"
step "Typecheck API"; npm run typecheck -w @app/api || npx tsc -p apps/api/tsconfig.json --noEmit || err "typecheck API falhou"
step "Typecheck Web"; npm run typecheck -w @app/web || npx tsc -p apps/web/tsconfig.json --noEmit || err "typecheck Web falhou"
step "Lint API"; npm run lint -w @app/api || echo "(sem lint)"
step "Lint Web"; npm run lint -w @app/web || echo "(sem lint)"
step "Build API"; npm run build -w @app/api || npm run build --workspace=@app/api || err "build API falhou"
step "Build Web"; npm run build -w @app/web || npm run build --workspace=@app/web || err "build Web falhou"
if [[ $FAILED -eq 0 ]]; then echo "✅ Doctor OK"; else echo "⚠️  Doctor encontrou erros"; exit 1; fi

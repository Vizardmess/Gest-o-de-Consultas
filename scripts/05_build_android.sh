#!/usr/bin/env bash
set -euo pipefail
REPO=${1:-}
if [[ -z "$REPO" ]]; then echo "Uso: $0 /caminho/do/repo"; exit 1; fi
cd "$REPO"
npm run build -w @app/web || npm run build --workspace=@app/web
npx cap sync android -w @app/web || npx cap sync android --workspace=@app/web
pushd apps/web/android >/dev/null
./gradlew --no-daemon clean :app:bundleRelease :app:assembleRelease
popd >/dev/null
echo "AAB/APK prontos em apps/web/android/app/build/outputs/{bundle,apk}/release"

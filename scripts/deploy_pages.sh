#!/usr/bin/env bash
# Builds the web release and publishes it to the gh-pages branch.
# Live at https://martinvermel.github.io/interactive_resume/
set -euo pipefail

FLUTTER="${FLUTTER:-$HOME/flutter/bin/flutter}"
REPO_URL="$(git config --get remote.origin.url)"
ROOT="$(git rev-parse --show-toplevel)"
SHA="$(git rev-parse --short HEAD)"

cd "$ROOT"
"$FLUTTER" build web --release --base-href /interactive_resume/

OUT="$(mktemp -d)"
cp -R build/web/. "$OUT/"
touch "$OUT/.nojekyll"

cd "$OUT"
git init -q -b gh-pages
git add -A
git commit -qm "Deploy resume ($SHA)"
git push -q --force "$REPO_URL" gh-pages
echo "Deployed $SHA. GitHub Pages takes ~1 min to update."

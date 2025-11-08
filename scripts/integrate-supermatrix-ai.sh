#!/usr/bin/env bash
set -euo pipefail

# This script integrates a forked n8n repository into the Supermatrix–AI monorepo.
# Update the environment variables below before running.

SUPER_MATRIX_DIR="${SUPER_MATRIX_DIR:-$HOME/github/supermatrix-ai}"
GITHUB_USERNAME="${GITHUB_USERNAME:-<YOUR-GITHUB-USERNAME>}"
N8N_SOURCE_DIR="${N8N_SOURCE_DIR:-$HOME/github/n8n}"

if [[ "$GITHUB_USERNAME" == "<YOUR-GITHUB-USERNAME>" ]]; then
  echo "Please set GITHUB_USERNAME to your GitHub handle before running this script." >&2
  exit 1
fi

if [[ ! -d "$SUPER_MATRIX_DIR/.git" ]]; then
  echo "Supermatrix–AI repository not found at $SUPER_MATRIX_DIR" >&2
  exit 1
fi

if [[ ! -d "$N8N_SOURCE_DIR/.git" ]]; then
  echo "n8n repository not found at $N8N_SOURCE_DIR" >&2
  exit 1
fi

cd "${SUPER_MATRIX_DIR}"

git remote add n8n-origin "https://github.com/${GITHUB_USERNAME}/n8n.git" || \
  git remote set-url n8n-origin "https://github.com/${GITHUB_USERNAME}/n8n.git"

git fetch n8n-origin

git merge n8n-origin/main --allow-unrelated-histories -m \
  "🔗 Integrated forked n8n automation engine into Supermatrix–AI core for workflow orchestration, automation & consolidation"

mkdir -p integrations/n8n

rsync -a --delete "${N8N_SOURCE_DIR}/" integrations/n8n/ \
  --exclude ".git"

echo "✅ N8N successfully integrated with Supermatrix–AI FusionLinker, TimeMachine, Trinity–X, and Promora modules."

git add .

git commit -m "♻️ Merge complete: n8n automation platform unified under Supermatrix–AI ecosystem"

git push origin main

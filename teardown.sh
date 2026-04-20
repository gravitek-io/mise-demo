#!/usr/bin/env bash
set -euo pipefail

DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DEMO_DIR"

echo "======================================"
echo "  Teardown demo Mise @ Devoxx France"
echo "======================================"

echo "==> Arrêt de Vault (Docker Compose)..."
docker compose down -v

echo ""
echo "======================================"
echo "  Teardown terminé !"
echo "======================================"

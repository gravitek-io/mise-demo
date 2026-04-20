#!/usr/bin/env bash
set -euo pipefail

DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DEMO_DIR"

echo "======================================"
echo "  Setup demo Mise @ Devoxx France"
echo "======================================"

# 1. Démarrage de Vault
echo ""
echo "==> Démarrage de Vault (Docker Compose)..."
docker compose up -d

# 2. Attente que Vault soit prêt
echo "==> Attente que Vault soit prêt..."
for i in $(seq 1 30); do
  if curl -sf http://127.0.0.1:8200/v1/sys/health > /dev/null 2>&1; then
    echo "    Vault est prêt !"
    break
  fi
  if [ "$i" -eq 30 ]; then
    echo "    ERREUR: Vault n'a pas démarré dans les temps"
    exit 1
  fi
  sleep 1
done

# 3. Seed Vault
echo "==> Seeding de Vault..."
eval "$(mise hook-env -s bash 2>/dev/null)"
bash vault/seed.sh

# 4. Téléchargement de demo-magic
if [ ! -f "$DEMO_DIR/lib/demo-magic.sh" ]; then
  echo "==> Téléchargement de demo-magic..."
  curl -fsSL https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh \
    -o "$DEMO_DIR/lib/demo-magic.sh"
fi

# 5. Succès
echo ""
echo "======================================"
echo "  Setup terminé avec succès !"
echo "======================================"
echo ""
echo "  Vault:        http://127.0.0.1:8200 (token: demo-root-token)"
echo ""
echo "  Lancer les demos: mise run demo-01"
echo "======================================"

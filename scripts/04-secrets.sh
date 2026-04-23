#!/usr/bin/env bash
DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
eval "$(mise activate bash)"
source "$DEMO_DIR/lib/demo-magic.sh"
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

clear

echo "# Demo 04 : Secrets via fnox + Vault"

pe "cd projects/calcium"

echo "# Les secrets sont injectés automatiquement par fnox depuis Vault"
pe "fnox list | grep demo"
pe "echo \$OVH_APPLICATION_KEY"
pe "echo \$OS_USERNAME"
pe "echo \$RANCHER_ACCESS_KEY"

pe "bat -pp fnox.toml"
wait

pe "cd ../lithium"

echo "# Mêmes variables, valeurs par défaut pour lithium (fnox pas activé)"
pe "echo \$OS_USERNAME"
wait

echo "# Fin de la demo 04"

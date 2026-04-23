#!/usr/bin/env bash
DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
eval "$(mise activate bash)"
source "$DEMO_DIR/lib/demo-magic.sh"
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

clear

echo "# Demo 03 : Variables d'environnement automatiques"

pe "cd projects/helium"

pe "echo \$PROJECT_NAME - \$CLUSTER_NAME - \$OS_REGION_NAME"
wait
pe "grep '\[env\]' -A7 mise.toml"
pe "cat .envrc"

pe "cd dev"

pe "echo \$PROJECT_NAME - \$CLUSTER_NAME - \$OS_REGION_NAME"
pe "kubectl config current-context"
pe "grep '\[env\]' -A1 mise.toml"
wait

pe "cd ../../lithium/prod"
pe "kubectl config current-context"

pe "echo \$PROJECT_NAME - \$CLUSTER_NAME - \$OS_REGION_NAME"
wait

echo "# Fin de la demo 03"

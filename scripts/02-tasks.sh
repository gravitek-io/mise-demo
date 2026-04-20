#!/usr/bin/env bash
DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
eval "$(mise activate bash)"
source "$DEMO_DIR/lib/demo-magic.sh"
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

clear

p "# Demo 02 : Tasks avec mise"

pe "cd projects/helium/dev/quarkus"
cd "$DEMO_DIR/projects/helium/dev/quarkus"

pe "java --version"

pe "mise tasks --local"
wait

pe "cat mise.toml"
wait

pe "mise run test"

p "# Fin de la demo 02"

#!/usr/bin/env bash
DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
eval "$(mise activate bash)"
source "$DEMO_DIR/lib/demo-magic.sh"
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

# Set default legacy version
mise use java@temurin-17
mise use python@3.11
eval "$(mise hook-env -s bash 2>/dev/null)"
clear

echo "# Demo 01 : Gestion des versions avec mise"
pe "grep '\[tools\]' -A5 mise.toml"
wait

pe "java --version"
pe "mise use java@temurin-25 --force"
eval "$(mise hook-env -s bash 2>/dev/null)"
pe "java --version"
wait

pe "python --version"
pe "mise use python@3.14"
eval "$(mise hook-env -s bash 2>/dev/null)"
pe "python --version"
wait

pe "grep '\[tools\]' -A5 mise.toml"
wait

pe "mise list"
wait

pe "mise ls-remote java | egrep 'temurin.*LTS'"
wait

pe "mise registry | grep kubectl"
wait

echo "# Fin de la demo 01"

# Reset default legacy version
mise use java@temurin-17
mise use python@3.11

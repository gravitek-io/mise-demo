#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="demo-root-token"

echo "==> Activation du moteur KV v2..."
vault secrets enable -path=secret -version=2 kv 2>/dev/null || true

echo "==> Seeding secrets calcium..."
vault kv put secret/myorg/ovh/calcium/API_CREDENTIALS \
  OVH_APPLICATION_KEY="demoAK123calcium" \
  OVH_APPLICATION_SECRET="demoAS456calcium" \
  OVH_CLOUD_PROJECT_SERVICE="demoPROJ789calcium" \
  OVH_CONSUMER_KEY="demoCK012calcium"

vault kv put secret/myorg/ovh/calcium/openstack/admin \
  OS_TENANT_NAME="calcium-tenant" \
  OS_USERNAME="calcium-admin" \
  OS_PASSWORD="calcium-s3cret-pwd" \
  AWS_ACCESS_KEY_ID="AKIAcalcium00DEMO" \
  AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/calcium00DEMO"

echo "==> Seeding secrets rancher..."
vault kv put secret/myorg/rancher/admin \
  ACCESS_KEY="token-rancher-demo-ak" \
  SECRET_KEY="rancherSK-demo-s3cret-value"

echo "==> Vault seedé avec succes !"

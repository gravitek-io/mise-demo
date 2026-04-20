# Demo Mise @ Devoxx France 2026

Environnement de demo reproductible pour la présentation **"Mise : un multi-outil pour votre poste de Dev & Ops"**.

## Prérequis

- Docker (avec Compose)
- [mise](https://mise.jdx.dev/)
- [vault](https://developer.hashicorp.com/vault/install) (CLI)
- curl

## Quickstart

```bash
mise run setup      # Monte Vault + seed secrets + télécharge demo-magic
mise run demo-01    # Lance la demo 01
mise run teardown   # Nettoie tout
```

## Architecture

```
mise-demo/
├── docker-compose.yml          # Vault dev server (hashicorp/vault:1.21)
├── vault/seed.sh               # Peuple Vault avec secrets de demo
├── setup.sh                    # Setup complet (Vault, seed, demo-magic)
├── teardown.sh                 # Nettoyage complet
├── mise.toml                   # Tasks : setup, teardown, demo-01 à demo-04
├── lib/
│   └── demo-magic.sh           # Téléchargé par setup.sh
├── scripts/
│   ├── 01-versions.sh          # Gestion des versions (Java, Python)
│   ├── 02-tasks.sh             # Tasks mise (Quarkus/Maven)
│   ├── 03-env.sh               # Variables d'environnement par projet/env
│   └── 04-secrets.sh           # Secrets fnox + Vault
└── projects/
    ├── helium/                 # Projet helium
    │   ├── mise.toml           # java temurin-25, python 3.14, hooks
    │   ├── .envrc              # PROJECT_NAME, VAULT_*, etc.
    │   ├── .tool-versions      # Versions des outils
    │   ├── dev/                # Env dev
    │   │   ├── mise.toml
    │   │   └── quarkus/        # Projet Quarkus avec tasks Maven
    │   │       ├── mise.toml   # java temurin-25, maven 3.9, tasks (build, test, lint...)
    │   │       ├── pom.xml
    │   │       └── src/
    │   └── prod/               # Env prod
    │       └── mise.toml
    ├── lithium/                # Projet lithium
    │   ├── mise.toml
    │   ├── .envrc
    │   ├── .tool-versions
    │   ├── dev/
    │   └── prod/
    └── calcium/                # Projet calcium (secrets fnox)
        ├── mise.toml
        ├── fnox.toml           # Providers Vault (calcium)
        ├── .envrc
        ├── .tool-versions
        ├── dev/
        └── prod/
```

## Composants

### Vault (Docker)

Vault tourne en mode dev avec le token `demo-root-token` sur `http://127.0.0.1:8200`.

Secrets seedés :
- `secret/myorg/ovh/calcium/API_CREDENTIALS` — clés API OVH calcium
- `secret/myorg/ovh/calcium/openstack/admin` — credentials OpenStack calcium
- `secret/myorg/rancher/admin` — credentials Rancher

### Projets mise

Trois projets sont disponibles : `helium/`, `lithium/`, et `calcium/`. Chaque projet utilise :
- **`.envrc`** — variables d'environnement projet (région, cluster, etc.)
- **`.tool-versions`** — versions des outils
- **`mise.toml`** — charge `.envrc`, définit les outils et hooks

Le projet `calcium/` inclut en plus :
- **`fnox.toml`** — providers Vault pour injection de secrets via fnox

Les sous-dossiers d'environnement (`dev/`, `prod/`) ajoutent :
- `CLUSTER_NAME` et `KUBECONFIG` via `.envrc`
- Configuration spécifique à l'environnement dans `mise.toml`

Le projet `helium/dev/quarkus/` contient un projet Quarkus complet avec des tasks Maven (install, build, test, lint, check, dev, start, clean).

## Demos

| Task | Description |
|------|-------------|
| `mise run demo-01` | Gestion des versions : `mise list`, `mise use java@temurin-25`, `mise use python@3.14`, registre |
| `mise run demo-02` | Tasks mise : tasks Quarkus/Maven dans helium (test, build, lint...) |
| `mise run demo-03` | Variables d'env : switch automatique entre helium et lithium par `cd` |
| `mise run demo-04` | Secrets fnox+Vault : injection transparente des secrets OVH/Rancher via calcium |

Les scripts utilisent [demo-magic](https://github.com/paxtonhare/demo-magic) pour un replay interactif des commandes.

## Setup / Teardown

### Setup (`mise run setup`)

1. Démarre Vault via Docker Compose
2. Attend que Vault soit healthy
3. Seed Vault avec les secrets de demo
4. Télécharge demo-magic dans `lib/`

### Teardown (`mise run teardown`)

1. Détruit les clusters Talos (si existants)
2. Arrête Vault et supprime les volumes Docker
3. Supprime les fichiers générés (kubeconfig, mise.local.toml)

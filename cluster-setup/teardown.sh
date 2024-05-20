#!/usr/bin/env bash

set -euo pipefail

kind delete cluster -n carvel
docker stop kind-registry.local
docker rm kind-registry.local

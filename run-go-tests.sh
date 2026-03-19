#!/usr/bin/env bash

set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "==> go-kata"

if (
    cd "$ROOT_DIR/go-kata" && go test ./...
); then
    echo "[PASS] go-kata"
    exit 0
fi

exit $?
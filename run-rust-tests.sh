#!/usr/bin/env bash

set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "==> rust-kata"

if (
    cd "$ROOT_DIR/rust-kata" && cargo test
); then
    echo "[PASS] rust-kata"
    exit 0
fi

exit $?
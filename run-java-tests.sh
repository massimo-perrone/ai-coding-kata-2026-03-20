#!/usr/bin/env bash

set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JAVA_DIR="$ROOT_DIR/java-kata"
WRAPPER_JAR="$JAVA_DIR/gradle/wrapper/gradle-wrapper.jar"

echo
echo "==> java-kata"

if [[ -x "$JAVA_DIR/gradlew" && -f "$WRAPPER_JAR" ]]; then
    if (
        cd "$JAVA_DIR" && ./gradlew --no-daemon test
    ); then
        echo "[PASS] java-kata"
        exit 0
    fi

    exit $?
fi

if command -v gradle >/dev/null 2>&1; then
    if (
        cd "$JAVA_DIR" && gradle --no-daemon test
    ); then
        echo "[PASS] java-kata"
        exit 0
    fi

    exit $?
fi

echo "[FAIL] java-kata (Gradle wrapper incomplete and no local gradle found)"
echo "       Expected wrapper jar: $WRAPPER_JAR"
exit 1
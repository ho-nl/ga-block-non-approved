#!/bin/sh
set -e
set -o pipefail

main() {
    echo "$GITHUB_EVENT_PATH"
}

main

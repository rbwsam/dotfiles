#!/bin/bash

set -euo pipefail

max=20

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <command> [args...]" >&2
    exit 1
fi

for ((i=1; i<=max; i++)); do
    echo "===== RUN $i/$max =====" >&2
    "$@"
done

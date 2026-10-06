#!/bin/bash
set -euo pipefail

limit="${1:-5}"
proto_file="${2:-/etc/protocols}"

if [[ ! -f "$proto_file" ]]; then
    printf 'Нет файла: %s\n' "$proto_file" >&2
    exit 1
fi

ranked=$(mktemp)
trap 'rm -f "$ranked"' EXIT

grep -Ev '^[[:space:]]*(#|$)' "$proto_file" \
    | awk 'NF >= 2 { printf "%s %s\n", $2, $1 }' \
    | sort -k1,1nr > "$ranked"

head -n "$limit" "$ranked"

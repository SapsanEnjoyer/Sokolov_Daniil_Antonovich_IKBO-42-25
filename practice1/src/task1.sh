#!/bin/bash
set -euo pipefail

passwd_file="${1:-/etc/passwd}"

if [[ ! -f "$passwd_file" ]]; then
    printf 'Нет файла: %s\n' "$passwd_file" >&2
    exit 1
fi

grep -v '^[[:space:]]*#' "$passwd_file" | grep -o '^[^:]*' | LC_ALL=C sort

#!/bin/bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    printf 'Использование: %s КАТАЛОГ [РАСШИРЕНИЕ]\n' "$0" >&2
    exit 1
fi

root="$1"
ext="${2:-txt}"
ext="${ext#.}"

if [[ ! -d "$root" ]]; then
    printf 'Нет каталога: %s\n' "$root" >&2
    exit 1
fi

find "$root" -maxdepth 1 -type f -name "*.${ext}" -size 0c -printf '%f\n' | LC_ALL=C sort

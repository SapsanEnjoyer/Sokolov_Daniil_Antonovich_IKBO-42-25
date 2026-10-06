#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    printf 'Использование: %s ФАЙЛ\n' "$0" >&2
    exit 1
fi

if [[ ! -f "$1" ]]; then
    printf 'Нет файла: %s\n' "$1" >&2
    exit 1
fi

names=$(grep -oE '[A-Za-z_][A-Za-z0-9_]*' "$1" | LC_ALL=C sort -u | paste -sd ' ' - || true)
printf '%s\n' "$names"

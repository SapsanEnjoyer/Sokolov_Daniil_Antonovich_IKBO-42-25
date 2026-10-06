#!/bin/bash
set -euo pipefail

root="${1:-.}"

if [[ ! -d "$root" ]]; then
    printf 'Нет каталога: %s\n' "$root" >&2
    exit 1
fi

while IFS= read -r -d '' path; do
    first=$(head -n 1 -- "$path" || true)
    name=$(basename -- "$path")

    case "$name" in
        *.py)
            pattern='^[[:space:]]*#'
            ;;
        *.c|*.js)
            pattern='^[[:space:]]*(//|/\*)'
            ;;
        *)
            continue
            ;;
    esac

    if printf '%s\n' "$first" | grep -Eq "$pattern"; then
        printf 'есть комментарий: %s\n' "$path"
    else
        printf 'нет комментария: %s\n' "$path"
    fi
done < <(find "$root" -type f \( -name '*.c' -o -name '*.js' -o -name '*.py' \) -print0 | sort -z)

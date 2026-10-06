#!/bin/bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    printf 'Использование: %s ВХОД ВЫХОД\n' "$0" >&2
    exit 1
fi

src="$1"
dst="$2"

if [[ ! -f "$src" ]]; then
    printf 'Нет файла: %s\n' "$src" >&2
    exit 1
fi

if [[ "$src" -ef "$dst" ]]; then
    printf 'Вход и выход не должны быть одним файлом\n' >&2
    exit 1
fi

awk '{ gsub(/    /, "\t"); print }' "$src" > "$dst"
printf 'Записано: %s\n' "$dst"

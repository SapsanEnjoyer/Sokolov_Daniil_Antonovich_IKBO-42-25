#!/bin/bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
    printf 'Использование: %s КАТАЛОГ РАСШИРЕНИЕ [АРХИВ]\n' "$0" >&2
    exit 1
fi

root="$1"
ext="${2#.}"
archive="${3:-${ext}_files.tar}"

if [[ ! -d "$root" ]]; then
    printf 'Нет каталога: %s\n' "$root" >&2
    exit 1
fi

first=$(find "$root" -type f -name "*.${ext}" -print -quit)
if [[ -z "$first" ]]; then
    printf 'Файлы *.%s не найдены в %s\n' "$ext" "$root" >&2
    exit 1
fi

find "$root" -type f -name "*.${ext}" -print0 \
    | tar --null -cf "$archive" -T -

printf 'Создан архив %s\n' "$archive"
tar -tf "$archive"

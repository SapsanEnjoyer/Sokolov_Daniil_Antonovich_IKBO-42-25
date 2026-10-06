#!/bin/bash
set -euo pipefail

root="${1:-.}"

if [[ ! -d "$root" ]]; then
    printf 'Нет каталога: %s\n' "$root" >&2
    exit 1
fi

find "$root" -type f -exec sha256sum {} + | LC_ALL=C sort | awk '
{
    sum = $1
    sub(/^[^ ]+[[:space:]]+/, "")
    if (count > 0 && sum != prev) {
        if (count > 1) {
            for (i = 1; i <= count; i++) {
                print items[i]
            }
            print ""
        }
        count = 0
    }
    count++
    items[count] = $0
    prev = sum
}
END {
    if (count > 1) {
        for (i = 1; i <= count; i++) {
            print items[i]
        }
        print ""
    }
}
'

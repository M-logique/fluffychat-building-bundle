#!/usr/bin/env bash
set -euo pipefail

URL="https://ftp.fau.de/kiwix/zim/wikipedia/wikipedia_en_all_maxi_2026-02.zim"
BASE="wikipedia_en_all_maxi_2026-02.zim.part"

curl -L "$URL" | split -a 4 -b 50M -d - "$BASE-" \
--filter='
  
  fname="$(basename "$FILE")"
  part="${fname##*-}"           
  part_num="$((10#$part))"      

  if [ "$part_num" -gt 311 ]; then
    echo "Uploading $FILE (part $part_num > 310)"
    curl --retry 5 --retry-delay 5 -T - "https://jchat.space/fat/fuck/$FILE"
  else
    echo "Skipping upload for $FILE (part $part_num <= 311)"
    
    cat >/dev/null
  fi
'

# !/usr/bin/bash

URL="https://ftp.fau.de/kiwix/zim/wikipedia/wikipedia_en_all_maxi_2026-02.zim"
BASE="wikipedia_en_all_maxi_2026-02.zim.part"

curl -L "$URL" | split -b 50M -d - "$BASE-" \
--filter='
    echo "Uploading $FILE"
    curl --retry 5 --retry-delay 5 -T - "https://matrix.hipoo.ir/fat/$FILE"
'
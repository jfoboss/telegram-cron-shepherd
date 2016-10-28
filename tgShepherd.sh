#!/bin/bash

# Simple Telegram message sender
#
# /etc/cron.d/sampleTgReminder
# 0 10,12,14,16 * * 1,2,3,4,5 root /usr/local/sbin/tgShepherd.sh -d random -m "Coffe break!"
# 
# https://github.com/jfoboss/telegram-cron-shepherd

CHATID="<your-chatId>"
BOT_ID="<your-botid>"

# Various NyanCat document IDs:
CATIMG=" \
BQADBAADbjIAAnQZZAeTGFHEM7wx_gI \
BQADBAADsx4AAr4eZAdJi4o9VNEn5AI \
BQADBAAD3QMAAiwZZAdBAcXY2zEAAU4C \
BQADBAADUTQAAtcYZAe5xEAHYcZMFAI \
BQADBAADFjQAAioYZAc-WJdds8DgbAI \
BQADBAADtDQAAjIdZAf5C8hWpe2_OgI \
BQADBAADXDQAAjEbZAfxYR0rqd5GpQI \
BQADBAADUDQAAtcYZAf5OBA6a9Z9kgI \
BQADBAADTjUAAtMbZAfoRc2112YJNwI \
BQADBAADjDQAAmIcZAds5ZOamK3VNgI \
BQADBAADJzQAAt0dZAdWoH-McpGiDwI \
BQADBAADGAQAAr8dZAfyjnKbVmWkLwI \
BQADBAADvzQAAsYYZAfbUcBpBNzRVQI \
BQADBAADfzQAAnsYZAdfllvKHNk6vgI \
BQADBAADNjQAAjweZAeaZ6x136awVgI \
BQADBAADNjQAAjwdZAe8M2yqOt-KDAI \
BQADBAADJjUAAhYYZAd1VoMckYT4lwI \
BQADBAADTDQAAiYYZAetVeNwarjfqwI \
BQADBAADTQMAAkcbZAfG5PQqHf46LwI \
BQADBAADmDQAAh0bZAcGukzcCeuEJwI \
"

function usage() {
    cat << EOF

Usage: $0 -m "<message>" [-d (random|<image_id>)]

Options:
    -m "<message>"         Send meaage

    -d (random|<image_id>) Send creepy random image or image with image_id

Example:
    $0 -m "Hello world!"
    Say hello in the chat

    $0 -m "Hello, nerdz!" -d random
    Say hello with random creepy image

    $0 -d <image_id>
    Send document hosted on telegram servers with document_id

EOF

}

if [ $# -eq 0 ] ; then
    usage
    exit 1
fi

MESSAGE="0"
SENDIMG="0"

while [[ $# > 1 ]]
    do
        key="$1"

        case ${key} in
            -m|--message)
                MESSAGE="$2"
                shift
            ;;
            -d|--document)
                SENDIMG="$2"
                shift
            ;;
            --default)
                DEFAULT=YES #sample valueless arguments
            ;;
            *)

            ;;
        esac
    shift
done

KATER=`shuf -n 1 -e $CATIMG`

if ! [ $MESSAGE = "0" ]; then
    echo "Result:"
    echo ""
    curl -X POST "https://api.telegram.org/bot$BOT_ID/sendMessage" -d "chat_id=$CHATID&text=$MESSAGE" | jq .
    echo ""
fi

if [ $SENDIMG = "random" ]; then
    echo "Result:"
    echo ""
    curl -X POST "https://api.telegram.org/bot$BOT_ID/sendDocument" -d "chat_id=$CHATID&document=$KATER" | jq .
    echo ""
else
    echo "Result:"
    echo ""
    curl -X POST "https://api.telegram.org/bot$BOT_ID/sendDocument" -d "chat_id=$CHATID&document=$SENDIMG" | jq .
    echo ""
fi

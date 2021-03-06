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
BQADBAADjTUAAxhkB8b4ipGtu2tvAg \
BQADBAADUzQAAlgZZAdeid-YAbvvNQI \
BQADBAADnjUAAkMaZAdGs7R3Z-834wI \
BQADBAADBAUAAgkaZAfH-I9BozhuVwI \
BQADBAADzQMAAvUaZAc3QtuOk9xXfwI \
BQADBAADUjQAAlgZZAf3Kqm-eqgEFAI \
BQADBAADozQAAngaZAeETCV80XoRyAI \
BQADBAADxgkAAmscZAdaNXGzthW5CQI \
BQADBAADmhsAAj0bZAdWKaSM2ntOjwI \
BQADBAADgAYAAg0eZAfRkKyoLYoF8AI \
BQADBAADRScAAi8aZAev7VR_f13swgI \
BQADBAADoycAAkceZAcW6Ok2mI5SWQI \
BQADBAAD-QUAAvkaZAfVP4Kl6KpXDQI \
BQADBAAD2TkAAsMeZAecdkG6pbLeKwI \
BQADBAADrgUAApQcZAfXCt9wGbekagI \
BQADBAAD7jAAAgkcZAdM6KOlc1DZMQI \
BQADBAADuToAAg4aZAcLZkzi6zF04AI \
BQADBAADSgMAAsgdZAcF1FOIrxsSlAI \
BQADBAADtTkAAkgZZAdQu3c92zxh9AI \
BQADBAADlDoAAssZZAfcFSKBdd380gI \
BQADBAAD2AMAAi4dZAcMOIoNihiCkwI \
BQADBAADRDoAAiAdZAdcfnQEU0lhqQI \
BQADBAADqgUAAkgcZAdohbsvXqAMwQI \
BQADBAADQToAArIXZAfgCevxZmjKXwI \
BQADBAADowUAAo0bZAeOZw-Q1-B7FgI \
BQADBAADPg8AAokXZAeSKq_Sx01qDwI \
BQADBAADAQUAAhkdZAfL4sWt46C5zAI \
BQADBAADkwQAAs8eZAdHy0R9Jo408AI \
BQADBAADyDkAAiwbZAeG-VFlhq_CQAI \
BQADBAADczoAAgEZZAdxyw1s-ZZA-QI \
BQADBAAD5DkAAn0ZZAcCFXGdY7ap6wI \
BQADBAADSzkAAj8bZAcpux5fKI5ixQI \
BQADBAADVjYAAgIdZAeTY3zAIyAj_wI \
BQADBAAD8DkAAhodZAf6zRvZLJfQpAI \
BQADBAAD7gcAAnkbZAdJ9eBvFEeBNQI \
BQADBAADpjkAArQYZAfe0PDf4Z6tPwI \
BQADBAADZDoAArUbZAfys8EBOPrt_AI \
"

function usage() {
    cat << EOF

Usage: $0 -m "<message>" [-d (random|<image_id>)]

Options:
    -m "<message>"         Send message

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

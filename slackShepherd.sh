#!/bin/bash

# Simple Slack message sender
#
# /etc/cron.d/sampleSlackReminder
# 0 10,12,14,16 * * 1,2,3,4,5 root /usr/local/sbin/slackShepherd.sh -d random -m "Coffe break!"
# 
# https://github.com/jfoboss/telegram-cron-shepherd

SLACK_WEBHOOK="https://hooks.slack.com/services/<hook>"

function usage() {
    cat << EOF

Usage: $0 -f "<fallback>" -h "<title>" -l "<tilte_link>" -t "<text>" -c "<color>"

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

while [[ $# > 1 ]]
    do
        key="$1"

        case ${key} in
            -f|--fallback)
                FALLBACK="$2"
                shift
            ;;
            -h|--header)
                TITLE="$2"
                shift
            ;;
            -l|--link)
                LINK="$2"
                shift
            ;;
            -t|--text)
                TEXT="$2"
                shift
            ;;
            -c|--color)
                COLOR="$2"
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

#if ! [ $TITLE = "0" ]; then
    echo "Result:"
    echo ""
#    curl -X POST "https://api.telegram.org/bot$BOT_ID/sendMessage" -d "chat_id=$CHATID&text=$MESSAGE" | jq .
    curl -X POST -H "Content-type: application/json" --data "{ \"attachments\": [ { \"fallback\": \"$FALLBACK\", \"title\": \"$TITLE\", \"title_link\": \"$LINK\", \"text\": \"$TEXT\", \"color\": \"$COLOR\" } ] }" $SLACK_WEBHOOK 2>/dev/null
    echo ""
#fi
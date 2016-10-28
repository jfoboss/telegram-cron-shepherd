# telegram-cron-shepherd
Simple Telegram message sender written in Bash

You need only Telegram api-key, curl & crontab rules.

`jq` is used only for debug purposes, you may remove it safely.

# Install 
`git clone --recursive https://github.com/jfoboss/telegram-cron-shepherd`

# Configure
1. Create Bot: https://core.telegram.org/bots#6-botfather
2. Put API key to `BOT_ID` variable
3. Enable bot in Telegram & add it to necessary chat
4. Gather chat ID using `https://api.telegram.org/bot<your_bot_id>/getUpdates`
5. Put chat id to `CHATID` variable

# Use
1. Create necessary CRON rules with messages
2. Profit!

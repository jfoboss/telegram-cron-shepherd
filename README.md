# telegram-cron-shepherd
Simple Telegram message sender written in Bash

# Install & Config
1. Create Bot: https://core.telegram.org/bots#6-botfather
2. Put API key to `BOT_ID` variable
3. Enable bot in Telegram
4. Add bot to necessary chat
3. Gather chat ID using `https://api.telegram.org/bot<your_bot_id>/getUpdates`
4. Put chat id to `CHATID` variable
5. Create necessary cron-rules with messages
6. Profit!

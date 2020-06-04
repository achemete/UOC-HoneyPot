#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Creation Monitor service started at ${DATE}" | systemd-cat -p info

MONITORDIR="/iot/"
inotifywait -m -r -e create --exclude '.*?\.swp' --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created"
		curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created." | tee -a /var/log/iot/fs/telegram/creationTelegram.log > /dev/null
        echo "CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created." >> /var/log/iot/fs/creation.log
done

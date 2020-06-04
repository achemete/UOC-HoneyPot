#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Deletion Monitor service started at ${DATE}" | systemd-cat -p info

MONITORDIR="/iot/"
inotifywait -m -r -e delete,delete_self --exclude '.*?\.swp' --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been deleted"
		curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been deleted." | tee -a /var/log/iot/fs/telegram/deletionTelegram.log > /dev/null
        echo "DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been deleted." >> /var/log/iot/fs/deletion.log
done

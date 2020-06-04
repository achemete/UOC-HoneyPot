#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Attribute Monitor service started at ${DATE}" | systemd-cat -p info

MONITORDIR="/iot/"
inotifywait -m -r -e attrib --exclude '.*?\.swp' --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "ATTB ALTERED - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} attributes have been altered to $(stat -c '%a' ${NEWFILE})"
		#curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="ALTERED - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} attributes have been altered." | tee -a /var/log/iot/fs/telegram/attribTelegram.log > /dev/null
        echo "ATTB ALTERED - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE}  attributes have been altered to $(stat -c '%a' ${NEWFILE})" >> /var/log/iot/fs/attrib.log
done

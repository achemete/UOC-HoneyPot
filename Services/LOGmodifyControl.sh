#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Modification Monitor service started at ${DATE}" | systemd-cat -p info

MONITORDIR="/iot/"
inotifywait -mre modify,close --exclude '.*?\.swp' --format 'Directory: %w - File: %f - Operation: %e - Path: %w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} actioned."
		#curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been modified." | tee -a /var/log/iot/fs/telegram/modifiedTelegram.log > /dev/null
        echo "MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} actioned." >> /var/log/iot/fs/modification.log
done

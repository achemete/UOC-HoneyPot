#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Listing Monitor service started at ${DATE}" | systemd-cat -p info

MONITORDIR="/iot/"
inotifywait -mre close,isdir --exclude '.*?\.swp' --format 'Directory: %w - Operation: %e - Path: %w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "BROWSING - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} listed."
		#curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="BROWSING - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been listed." | tee -a /var/log/iot/fs/telegram/listingTelegram.log > /dev/null
        echo "BROWSING - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} listed." >> /var/log/iot/fs/listing.log
done

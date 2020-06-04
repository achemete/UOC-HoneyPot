#!/bin/bash

file=/var/log/secure
#date just when zero is leading - day less than 10, still to fix.
fecha=$(date --date="yesterday" +"%-b  %-d")
when=${fecha##*( )}
#when="May 30"
while read line; do
		echo "date: $when"
        if [[ $line == *"$when"* && $line == *Failed* ]]; then
                #echo "FOUND Failed - $line"
				#echo $line >> "/var/log/iot/ssh/May_30-failed-logins_daily.log"
				echo $line >> "/var/log/iot/ssh/`date --date="yesterday" +"%-b_%-d"`-failed-logins_daily.log"
        elif [[ $line == "$when"* && $line == *Accepted* ]]; then
				#echo "FOUND accepted - $line"
				#echo $line >> "/var/log/iot/ssh/May_30-accepted-logins_daily.log"
				echo $line >> "/var/log/iot/ssh/`date --date="yesterday" +"%-b_%-d"`-accepted-logins_daily.log"
		fi
		
done < $file
curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="SSH Failed Logins collected as of $(date '+%d/%m/%Y %H:%M:%S')" | tee -a /var/log/iot/ssh/telegram/cron-jobs.log > /dev/null

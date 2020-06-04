#!/bin/bash

#Daily Digest failed and accepted logins

#`date --date="yesterday" +"%-b_%-d"`
ACCEPTED=/var/log/iot/ssh/`date --date="yesterday" +"%-b_%-d"`-accepted-logins_daily.log
FAILED=/var/log/iot/ssh/`date --date="yesterday" +"%-b_%-d"`-failed-logins_daily.log

if [ -f "$ACCEPTED" ]; then
    #echo "$FILE exist"
	#Non-root users list:
	awk '$11 ~ /^[a-z,A-Z]/{print $11}' $ACCEPTED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-nonRoot-users.csv
	awk '$11 ~ /^[a-z,A-Z]/{print $11}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-nonRoot-users.csv
	#Root users list: 
	awk '$9 ~ /^[a-z,A-Z]/{print $9}' $ACCEPTED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-root-users.csv
	awk '$9 ~ /^[a-z,A-Z]/{print $9}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-root-users.csv
	#Non-root IP list:
	awk '$13 ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $13}' $ACCEPTED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-nonRoot-ips.csv 
	awk '$13 ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $13}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-nonRoot-ips.csv
	#Root IP list:
	awk '$11 ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $11}' $ACCEPTED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-root-ips.csv 
	awk '$11 ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $11}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-root-ips.csv
	
else
	#Non-root users list:
	awk '$11 ~ /^[a-z,A-Z]/{print $11}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-nonRoot-users.csv
	#Root users list:
	awk '$9 ~ /^[a-z,A-Z]/{print $9}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-root-users.csv 
	#Non-root IP list:
	awk '$13 ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $13}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-nonRoot-ips.csv 
	#Root IP list
	awk '$11 ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $11}' $FAILED | sort | uniq -c > /var/log/iot/ssh/Digest/`date --date="yesterday" +"%-b_%-d"`-root-ips.csv
fi
curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="SSH Users were processed as of $(date '+%d/%m/%Y %H:%M:%S')" | tee -a /var/log/iot/ssh/telegram/cron-jobs.log > /dev/null
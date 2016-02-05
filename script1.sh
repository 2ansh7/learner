#!/bin/sh
# this script use for system health checkup
echo `date` >> `pwd`/my.log
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' | tee -a `pwd`/my.log
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}' | tee -a `pwd`/my.log
top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' | tee -a `pwd`/my.log
Used=`free -m | awk 'NR==2{printf"%s",$3}'`
Total=`free -m | awk 'NR==2{printf"%s",$2}'`
if [ "$(( $Used + 500 ))" -gt "$Total" ]; then echo -e "Memory Usage: High \nMemory Cache needs to flush. Contact your Administrator." | tee -a `pwd`/my.log; fi  
echo >> `pwd`/my.log

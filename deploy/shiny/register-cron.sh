#!/usr/bin/env bash
# This is used to avoid having the "*" sign to get commands on bin
set -f 

rm -f /etc/cron.d/update_shiny_files

if [ ! -d /var/log/shiny-server/ ]; then
    mkdir -p /var/log/shiny-server/
fi

CRON_CMD="*/20 * * * *  root  bash /shiny-scripts/poll.sh > /var/log/shiny-server/poll.log 2>&1 "

echo $CRON_CMD >> /etc/cron.d/update_shiny_files
echo "" >> /etc/cron.d/update_shiny_files
service cron restart
echo "Crontab job to poll shiny dashboards set at: /etc/cron.d/update_shiny_files"

echo "Executing immediately: /shiny-scripts/poll.sh"
bash /shiny-scripts/poll.sh
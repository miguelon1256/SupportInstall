#!/bin/bash
set -e
# Deletes tmp file, clones from main branch, moves to directory and 
echo $(date)
echo "Executing clone of shiny dashboards"
rm -rf /tmp/dashboards-shiny
git clone -b main --depth 1 https://github.com/NexionBolivia/dashboards-shiny.git /tmp/dashboards-shiny
cp -rf /tmp/dashboards-shiny/* /srv/shiny-server/
echo $(date) > /srv/shiny-server/last_updated.txt
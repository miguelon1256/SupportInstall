#!/bin/bash
set -e
# Deletes tmp file, clones from main branch, moves to directory and 
echo $(date)
echo "Executing clone of shiny dashboards"
rm -rf /tmp/dashboards-shiny
git clone -b main --depth 1 https://github.com/kobo-ProAgenda2030/dashboards-shiny.git /tmp/dashboards-shiny

echo "Now copyng to location..."
# Removing any previous shiny-server-new directory
if [[ -d /srv/shiny-server-new ]]; then
    rm -rf /srv/shiny-server-new
fi
if [[ ! -d /srv/shiny-server-new ]]; then
    mkdir -p /srv/shiny-server-new
fi

# Moving from tmp to new dir
cp -rf /tmp/dashboards-shiny/* /srv/shiny-server-new/

# Removing any previous shiny-sever-old directory
if [[ -d /srv/shiny-server-old ]]; then
    rm -rf /srv/shiny-server-old
fi
if [[ ! -d /srv/shiny-server-old ]]; then
    mkdir -p /srv/shiny-server-old
fi
# Renaming currenct shiny-server
mv /srv/shiny-server/* /srv/shiny-server-old/

# Replacing new directory 
cp -rf /srv/shiny-server-new/* /srv/shiny-server/

rm -rf /srv/shiny-server-new
rm -rf /srv/shiny-server-old

current=$(date)
echo $current > /srv/shiny-server/last_updated.txt
echo "Poll executed at: ${current}"
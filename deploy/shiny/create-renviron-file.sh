#!/bin/bash

if [[ $DASHBOARDS_KOBO_TOKEN ]]; then
    echo "DASHBOARDS_KOBO_TOKEN=${DASHBOARDS_KOBO_TOKEN}" > /home/shiny/.Renviron
else 
    echo "No env var found: DASHBOARDS_KOBO_TOKEN"
fi
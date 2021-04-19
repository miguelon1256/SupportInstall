version: "3.0"

services:
  dashboards:
    image: proagenda2030/dashboards:pa.1.0.2
    restart: always
    user: 'root'
    # Uncomment the lines below to disable application logs STDOUT output
    # environment:
    #   - APPLICATION_LOGS_TO_STDOUT=false
    ports:
      - '${DASHBOARDS_PORT}:3838'
    command: "bash /shiny-scripts/entrypoint.sh"
    restart: always
    volumes:
      - 'shiny_logs:/var/log/shiny-server'
      # Comment the line below out for initial testing. With it commented out,
      # going to localhost:80 in one's web browser will show a "Welcome to
      # Shiny Server!" diagnostics page.
      - './dashboards:/srv/shiny-server'
      - ./shiny-scripts:/shiny-scripts
    env_file:
      - ./database.txt
      - ./dashboards.txt
      
volumes:
  shiny_logs:
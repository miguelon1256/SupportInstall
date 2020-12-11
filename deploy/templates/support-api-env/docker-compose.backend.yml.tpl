# For public, HTTPS servers.
version: '3'

services:
  postgres:
    image: postgres:12.5
    hostname: postgres
    env_file:
      - ./envfiles/databases.txt
      - ../../kobo-env/envfiles/aws.txt
    volumes:
      - ./.vols/db:/var/lib/postgresql/data
      - ./backups/postgres:/srv/backups
      - ./log/postgres:/srv/logs
      - ./postgres:/support-db-docker-scripts
    command: "bash /support-db-docker-scripts/entrypoint.sh"
    restart: always
    stop_grace_period: 5m
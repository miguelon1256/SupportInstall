version: '3'

services:
  support-postgres:
    image: postgres:12.5-alpine
    container_name: support-postgres
    restart: unless-stopped
    env_file: 
      - ./database.txt
    ports:
      - "${SUPPORT_DB_PORT}:${SUPPORT_DB_INTERNAL_PORT}"
    volumes:
      - support-postgres-data:/var/lib/postgres
  
  support-postgres-bootstrap:
    image: proagenda2030/support_bootstrap:bootstrap.v0.0.7
    container_name: support-postgres-bootstrap
    restart: 'no'
    depends_on:
      - support-postgres
    env_file:
      - ./database.txt
    

volumes:
  support-postgres-data:
    driver: local

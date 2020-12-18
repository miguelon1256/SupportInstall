version: '3'

services:
  support-api:
    image: proagenda2030/support_api:pa.v0.5.0
    hostname: support_api
    container_name: support_api
    restart: unless-stopped
    env_file:
      - ./database.txt

networks:
  default:
    external:
      name: support_api-network
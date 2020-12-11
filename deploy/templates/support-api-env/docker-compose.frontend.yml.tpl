version: '3'

services:
  support-api:
    #image: support-dev:latest
    image: proagenda2030/support_api:pa.v0.4
    hostname: support_api
    container_name: support_api
    restart: unless-stopped

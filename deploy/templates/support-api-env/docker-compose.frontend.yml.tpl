version: '3'

services:
  support-api:
    image: proagenda2030/support_api:pa.v1.0.0
    hostname: support_api
    container_name: support_api
    extra_hosts:
      - "kf.mmaya.gob.bo kc.mmaya.gob.bo ee.mmaya.gob.bo:192.168.5.151"
    restart: unless-stopped
    env_file:
      - ./database.txt

networks:
  default:
    external:
      name: support_api-network
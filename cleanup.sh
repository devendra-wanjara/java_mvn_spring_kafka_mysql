#! /bin/sh

docker compose -f docker-compose.dev.yml down
docker system prune -af 
docker builder prune -af
docker system prune -af
docker volume prune -f

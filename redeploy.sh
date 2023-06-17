#!/bin/bash
docker stop twiscord && docker rm -f twiscord
sudo docker build -t twiscord -f $(pwd)/infra/docker/twiscord/Dockerfile . --no-cache
sudo docker run -d --link redis --network gem --name twiscord -v $(pwd)/infra/data/twiscord-logs/:/usr/src/app/logs/ twiscord
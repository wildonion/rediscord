
# 🤖 rediscord Bot

> [bot link](https://discord.com/api/oauth2/authorize?client_id=1121128286433595504&permissions=274877908992&scope=bot)

this bot subscribes to redis pubsub channels related to twitter's mentions, tweets and replies topics and send them to the specified channel in discord. 

> with [bot link](https://discord.com/api/oauth2/authorize?client_id=1121128286433595504&permissions=274877908992&scope=bot) we can add the conse bot to discord servers. 

> get token from [here](https://discord.com/developers/applications/1121128286433595504/bot)

this bot subscribes to redis pubsub channels related to twitter's mentions, tweets and replies topics and send them to the specified channel in discord. 

**Code Flow:**

```
in twitter bot server 
    |
    |------ once the fetch user mentions api is called
    | 
     ------ publish response to redis pubsub channel

in discord ws/http client 
    |
    |------ subscribe to the published tweets inside the event listener (loop {})
    |
     ------ send them to all discord channel(s) of all guilds that this bot is inside
```

## 🚀 Deploy

Make sure that 

- you've setup the token and discord channel id inside `.env` file already by building a new application and inivitation link for the this bot inside the discord developer panel.

- this bot and redis must be in a same docker network.

- you've setup the [twidis](https://github.com/wildonion/twidis) bot already in order to get this bot works.  

```bash
sudo docker network create -d bridge gem || true
export PASSEORD=geDteDd0Ltg2135FJYQ6rjNYHYkGQa70
docker run -d \
    -h redis \
    -e REDIS_PASSWORD=$PASSEORD \
    -v $(pwd)/infra/data/redis/:/data \
    -p 6379:6379 \
    --name redis \
    --network gem \
    --restart always \
    redis:latest /bin/sh -c 'redis-server --appendonly yes --requirepass ${REDIS_PASSWORD}'

sudo docker build -t rediscord -f $(pwd)/infra/docker/rediscord/Dockerfile . --no-cache
sudo docker run -d --link redis --network gem --name rediscord -v $(pwd)/infra/data/rediscord-logs/:/usr/src/app/logs/ rediscord
```

### 🥧 Twiscord Architecture Diagram

<p align="center">
    <img src="https://github.com/wildonion/rediscord/blob/main/rediscord.png">
</p>

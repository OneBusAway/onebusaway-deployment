#!/bin/bash
# install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

cd /home/${user}

# clone repo
git clone https://github.com/onebusaway/onebusaway-docker.git

cd /home/${user}/onebusaway-docker

# create .env file
echo "${docker_env}" > .env


# onebusaway-api-webapp depends on mysql, normally this will handle by docker-compose
# but in Azure, the mysql container will not be ready when onebusaway-api-webapp starts
# which leads to the error `Access to DialectResolutionInfo cannot be null when 'hibernate.dialect' not set`
# so we need to start mysql container first
docker-compose -f docker-compose.prod.yml up -d oba_database

sleep 5s

# start Docker Compose
docker-compose -f docker-compose.prod.yml up -d

if [ -n "${caddy}" ]; then
    # create docker-compose.caddy.yml
    echo "${docker_compose}" > docker-compose.caddy.yml
    # start Caddy
    docker-compose -f docker-compose.caddy.yml up -d
fi

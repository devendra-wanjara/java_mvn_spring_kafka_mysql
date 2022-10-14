# play-docker-compose-dev-container
To play with docker, docker compose, use dev containers to bring up Services like Kafka, DB etc and Spring boot app
this is a test


## TODO 
when docker compose 2.11.2 is available I will have to simply rebuild and it will 

use fulle commands for DB
 
[Github](https://www.github.com "Github home")

# DOCKER

### DOCKER COMPOSE
1. To remove all cache for compose \
`docker compose rm --all`

### Docker Network Inspect 

1. 
```yml
#To get **network** name and **ip** addres of all running containers

docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
``` 

```yml
#To get **All containers in a network** name and **ip** addres of all running containers
docker network inspect exampleNetworkName -f '{{ range.Containers}}{{.IPv4Address}}{{end}}`
```
3. 
```yml
# List all networks a container belongs to
docker inspect -f '{{range $key, $value := .NetworkSettings.Networks}}{{$key}} {{end}}' [container]
```

# START
# List all networks a container belongs to
docker inspect -f '{{range $key, $value := .NetworkSettings.Networks}}{{$key}} {{end}}' [container]
# List all containers belonging to a network by name
`docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' [network]`
# Attach a running container to a network
docker network connect [network] [container]
# Start a container attached to a specific network
docker run --network [network] [container]
# With containerA already running, test if containerA can connect to containerB by using its name
docker exec [containerA] ping [containerB] -c2
# Create a network
docker network create [network]
# Find out if an IP address is reachable from a container
docker exec [container] ping [ip_address] -c2
# Get a container's IP address inside a specific network
docker inspect -f '{{.NetworkSettings.Networks.[network].IPAddress}}' [container]
# Get ICC setting for a specific network
docker inspect -f '{{index .Options "com.docker.network.bridge.enable_icc"}}' [network]
# Create a network and explicitly enable ICC
docker network create -o com.docker.network.bridge.enable_icc=true [network]


# END

### Docker start special case

1. Start container from **Image** and override the default enterypoint\
```yml
sudo docker run -it --entrypoint /bin/bash [docker_image]
```

2. To get into a running container and override the default enterypoint\
```yml
docker exec -it  container_NAME  /bin/bash
```  

### DOCKER Create VOLUME for DB etc. 
1. Start container from **Image** and override the default enterypoint\
```yml
docker volume create --name my-app
``` 


## Docker clean up
1. Start container from **Image** and override the default enterypoint\
```yml
docker system prune -f 
```
```yml
docker builder prune -af
```



# DOCKER DB COMMAND MySQL Maria connect to DB in container and show tables 
docker run --rm -d   -e MYSQL_ROOT_PASSWORD=db-57xsl   -e MYSQL_DATABASE=db   -e MYSQL_USER=root   -e MYSQL_PASSWORD=db-57xsl   --name=mariadb_test   mariadb:10.6.4-focal && sleep 3 && docker exec 58e769c0af82 mysql -uroot -pdb-57xsl -e 'show databases' && docker kill mariadb_test

#

## Docker compose Clean build 
#Recommended approach :

1) Force the execution of each step/instruction in the Dockerfile :

docker build --no-cache 
or with docker-compose build :

docker-compose build --no-cache
We could also combine that to the up sub-command that recreate all containers:

docker-compose build --no-cache &&
docker-compose up -d --force-recreate 
These way don't use cache but for the docker builder and the base image referenced with the FROM instruction.

2) Wipe the docker builder cache (if we use Buildkit we very probably need that) :

    # IMP
    docker builder prune -af
3) If we don't want to use the cache of the parent images, we may try to delete them such as :

docker image rm -f fooParentImage

# SYSTEM COMMAND
ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1
# SYSTEM COMMAND PACKAGE install 
apt update
apt install iproute2 net-tools vim 
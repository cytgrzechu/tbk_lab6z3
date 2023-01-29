docker kill $(docker ps -q)
docker rm $(docker ps -aq)

docker volume rm pg-data

docker container rm -f $(docker container ls -aq)
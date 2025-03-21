# docker run command
docker run --name es01 --net elastic -p 9200:9200 -it -m 1GB docker.elastic.co/elasticsearch/elasticsearch:8.15.3


# copy the certificate file
docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt .
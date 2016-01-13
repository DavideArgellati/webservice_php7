###docker compose for a php7 based infrastructure###
#####includes redis, memcached, mariadb, nginx+php-fpm####

###Requirments:###
* docker
* docker-compose

###Use:###
* rename envars.sample to envvars
* add you nginx vhosts into nginx ./frontend/webservernginx/nginx/sites-available
* run ./composeup.sh it will source the envvars and start docker

###Details:###
mariadb will create a db with user and password specified in envvars,
to import an existing db or run other scripts/sql put it on mariadbserver/docker-entrypoint-initdb.d
.sh and .sql will be executed automatically.
mysql data volume is in the local folder ./data/mariadb alternative would be building a dedicated docker volume container
redis persistency data volume is in the local folder ./data/redis

#####refer to official documentations for extra settings#####
https://hub.docker.com/_/mariadb/
https://hub.docker.com/_/redis/
https://hub.docker.com/_/memcached/

windows/mac use https://docs.docker.com/machine/ or a linux vm

######TODO:######
refactor scripts and nginx conf

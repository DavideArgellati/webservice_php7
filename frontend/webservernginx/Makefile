# Build a container via the command "make build"
#CODEPATH defined in sourcecodepath and sourced

NAME = practicefinderfrontendnginx
IMAGE_NAME='practicefinder/frontendnginx'
DOCKER="docker"

all:: help


help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "     make build        - Build the $(NAME) image"
	@echo "     make run          - Run $(NAME)"
	@echo "     make start        - Start the EXISTING $(NAME) container"
	@echo "     make stop         - Stop $(NAME) container"
	@echo "     make restart      - Stop and start $(NAME) container"
	@echo "     make remove       - Stop and remove $(NAME) container"
	@echo "     make state        - View state $(NAME) container"
	@echo "     make logs         - View logs in real time"

build:
	docker build -t $(IMAGE_NAME) .
runnginxonly:
	@echo "Run $(IMAGE_NAME)..."
	docker run -d -p 8082:80 -p 44343:443 -v "/media/davide/D/www:/home/www" -t -i --name $(NAME) $(IMAGE_NAME)

run: 
	@echo "Run $(IMAGE_NAME)..."
	docker run -d -p 8082:80 -p 44343:443 -v "/media/davide/D/www:/home/www" -t -i --name $(NAME) --link practicefindermariadb:mysqlserver --link practicefinderredis:redisserver --link practicefindermemcache:memcacheserver $(IMAGE_NAME)

start:
	@echo "Starting $(NAME)..."
	docker start $(NAME) > /dev/null

buildrunall: buildrundep
	make build && make run

buildrundep:
	cd "../../mariadbserver" && make build && make run && cd "../redis" && make build && make run && cd "../memcache" && make build && make run

startdep:
	cd "../mariadbserver" && make start && cd "../../redis" && make start && cd "../memcache" && make start

stop:
	@echo "Stopping $(NAME)..."
	docker stop $(NAME) > /dev/null

restart: stop start

cleanup: stop
	 @echo "Removing $(NAME)..." 
	 docker rm $(NAME)

rebuild: cleanup build run

state:
	docker ps -a | grep $(NAME)

logs:
	@echo "Build $(NAME)..."
	docker logs -f $(NAME)
  
ssh:
	docker exec -ti $(NAME) bash


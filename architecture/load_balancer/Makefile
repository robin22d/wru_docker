
clean:
		docker ps -a -q | xargs -id docker rm -f d
		docker images -q | xargs -id docker rmi d

build:
		docker build -t wru_server server/.
		docker build -t wru_jmeter jmeter/.

compose:
		docker-compose up -d

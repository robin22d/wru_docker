
clean:
		docker ps -a -q | xargs -id docker rm -f d
		docker images -q | xargs -id docker rmi d

compose:
		docker-compose up -d

copy:
		docker cp wru_jmeter_1:/root/data/output.txt output_1.txt

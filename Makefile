default: start

dist.tar.gz:
	@echo "downloading wars"
	wget https://github.com/UAMS-DBMI/nbia_docker/releases/download/v0.9/dist.tar.gz
	tar xzf dist.tar.gz -C tomcatfiles/

start: dist.tar.gz
	@echo "starting containers"
	docker compose up -d

stop:
	@echo "stopping containers"
	docker compose down

clean:
	@echo "deleting volumes"
	docker compose down -v

default: start

dist.tar.gz:
	@echo "downloading wars"
	wget https://github.com/UAMS-DBMI/nbia_docker/releases/download/v0.9/dist.tar.gz

webapps: dist.tar.gz
	tar xzf dist.tar.gz
	touch webapps

start: webapps
	@echo "starting containers"
	docker compose up -d

stop:
	@echo "stopping containers"
	docker compose down

clean:
	@echo "deleting volumes"
	docker compose down -v
	rm dist.tar.gz
	rm -rif webapps

status:
	docker compose ps

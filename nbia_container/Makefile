default: build

copy:
	rm -irf installer/
	cp -r ~/work/NBIA-TCIA/software/target/dist/exploded installer/

build:
	docker build -t jrutecht/nbiatomcat:latest .

push:
	docker push jrutecht/nbiatomcat:latest

external:
	rm -irf installer/
	rm -irf ../tomcatfile/*
	cp -r ~/work/NBIA-TCIA/software/target/dist/exploded installer/
	cp config/external_install.properties installer
	ant installer/
	cp config/log4j.properties ../tomcatfile/lib
	cp config/nbia.properties ../tomcatfile/lib

default: build

copy:
	rm -irf installer/
	cp -r ~/work/NBIA-TCIA/software/target/dist/exploded installer/

build:
	docker build -t jrutecht/nbiatomcat:latest .

push:
	docker push jrutecht/nbiatomcat:latest

external:
	rm -irf installer
	rm -irf ../tomcatfile
	cp -r ~/work/NBIA-TCIA/software/target/dist/exploded installer/
	cp config/external_install.properties installer/install.properties
	ant -f installer/build.xml
	cp config/log4j.properties ../tomcatfiles/lib
	cp config/nbia.properties ../tomcatfiles/lib

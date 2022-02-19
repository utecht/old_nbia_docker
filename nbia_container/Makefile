default: build

copy:
	rm -irf installer/
	cp -r ~/work/NBIA-TCIA/software/target/dist/exploded installer/

build:
	docker build -t jrutecht/nbiatomcat:latest .

push:
	docker push jrutecht/nbiatomcat:latest
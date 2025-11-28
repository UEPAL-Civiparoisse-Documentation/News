.PHONY: build serve pull image clean servopen servclose servephp
image = squidfunk/mkdocs-material
builddir = MATERIAL
sitedir = site
servip = 127.0.0.1
servport = 8000
all: image build
image:
	rm -Rf ${builddir}
	git clone https://github.com/squidfunk/mkdocs-material.git ${builddir}
	docker build --rm --no-cache -t ${image} ${builddir}
	rm -Rf ${builddir}
build:
	docker run --rm -ti --mount type=bind,source=${CURDIR},destination=/docs --name="mkdocs_material"  ${image}  build -v -v -v
	php master_rss.php
serve:
	docker run  --rm -ti -h civiblog.test --ip 172.17.0.2 -p ${servip}:${servport}:8000 --mount type=bind,source=${CURDIR},destination=/docs --name="mkdocs_material" ${image}  serve -a 172.17.0.2:8000 -v -v -v

servopen: serve
	xdg-open http://${servip}:${servport}

servephp:
	php -S ${servip}:${servport} -t site

servclose:
	docker stop mkdocs_material

clean:
	rm -Rf ${builddir}
	rm -Rf ${sitedir}/*

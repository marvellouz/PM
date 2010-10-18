all: custom
custom:
	mv domain.png ../
pdf: domain
	cd ../../doc/ && make pdf
domain:
	./umlgraph domain png -outputencoding utf8  && mv domain.png ../
clean:
	rm -rf *png
	rm -rf __*log

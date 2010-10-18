all: pdf
html:   svgconvert
	xsltproc --nonet ./xslt/html/docbook.xsl doc.xml > doc.html
fo:     svgconvert
	xsltproc --nonet ./xslt/fo/docbook.xsl doc.xml > doc.pdf
pdf:    svgconvert
	#dblatex -d -p /home/emil/fmi/sem5/xml/doc.xsl doc.xml
	dblatex -d -b xetex -p ./style/doc.xsl --texstyle=./style/mystyle.sty doc.xml
clean:
	rm -rf doc.pdf *.log doc.html
svgconvert:
	cd ../diagrams/ && ./convert.sh #&& cd domain && make

all:	
	make tests
	make build
	make clean

tests:
	xmllint --noout --schema test-xsds/epp.xsd examples/reverse-request.xml
	xmllint --noout --schema test-xsds/epp.xsd examples/poll-response.xml

build:
	perl -pi -e 's/^(.)/C: \1/' < examples/reverse-request.xml > examples/reverse-request.txt
	perl -pi -e 's/^(.)/C: \1/' < examples/poll-response.xml > examples/poll-response.txt

	xmllint --xinclude draft-brown-epp-reverse.xml.in > draft-brown-epp-reverse.xml

	xml2rfc draft-brown-epp-reverse.xml draft-brown-epp-reverse.txt
	xml2rfc draft-brown-epp-reverse.xml draft-brown-epp-reverse.html

clean:
	rm -vf examples/*txt

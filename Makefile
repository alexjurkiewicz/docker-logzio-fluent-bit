all: out_logzio.so
	docker build -t alexjurkiewicz/logzio-fluent-bit:$(shell git describe --tag || echo unknown) .

out_logzio.so:
	curl -s -o out_logzio.so https://raw.githubusercontent.com/logzio/fluent-bit-logzio-output/master/build/out_logzio.so

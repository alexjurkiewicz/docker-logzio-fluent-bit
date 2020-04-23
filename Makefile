all: out_logzio.so
	docker build -t alexjurkiewicz/logzio-fluent-bit:$(shell git describe --tag || echo unknown) .

out_logzio.so:
	wget https://github.com/logzio/fluent-bit-logzio-output/blob/master/build/out_logzio.so

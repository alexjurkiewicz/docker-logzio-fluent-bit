# Build the plugin
FROM golang:1-buster as builder
WORKDIR /go/src/app
RUN go get -u github.com/golang/dep/cmd/dep
RUN curl -sL -o /archive.tar.gz https://github.com/logzio/fluent-bit-logzio-output/archive/master.tar.gz && \
  tar xzf /archive.tar.gz --strip-components 1 && \
  rm /archive.tar.gz
RUN dep ensure -vendor-only
RUN make all

# Final image
FROM fluent/fluent-bit
COPY plugins.conf /fluent-bit/etc/plugins.conf
COPY --from=builder /go/src/app/build/out_logzio.so /fluent-bit/plugins/out_logzio.so
ENTRYPOINT [ "/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf" ]

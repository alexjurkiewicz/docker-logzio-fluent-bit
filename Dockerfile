FROM fluent/fluent-bit

COPY fluent-bit-base.conf plugins.conf /fluent-bit/etc/

COPY out_logzio.so /fluent-bit/plugins/out_logzio.so

ENTRYPOINT [ "/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit-base.conf" ]

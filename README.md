# logzio-fluent-bit Docker image

This Docker image is an alternate to [the official Docker image supplied by logz.io](https://docs.logz.io/shipping/shippers/fluent-bit.html).

It's based off the upstream [fluent-bit Dockerfile](https://hub.docker.com/r/fluent/fluent-bit/), which has all default inputs & filters. (The logz.io image lacks for instance the `aws` filter.)

## Usage

1. Create a `fluent-bit.conf` file containing your configuration. Make sure to specify `Plugin_File plugins.conf` in your `[SERVICE]` section.

    Example config file:

    ```ini
    [SERVICE]
        Plugin_File plugins.conf
        Log_Level debug

    [INPUT]
        Name tail
        Path /host/var/log/syslog

    [FILTER]
        Name aws
        Match *
        imds_version v1

    [OUTPUT]
        Name logzio
        Match *
        logzio_token ${LOGZIO_TOKEN}
        logzio_type ${LOGZIO_TYPE}
    ```

2. Run the docker image:

    ```sh
    # These variables are referenced by the example config
    export LOGZIO_TOKEN=...
    export LOGZIO_TYPE=my-log-type

    docker run \
      --rm -it \
      -e LOGZIO_TOKEN -e LOGZIO_TYPE \
      -v "$(pwd)/fluent-bit.conf:/fluent-bit/etc/fluent-bit.conf" \
      -v /:/host \
      alexjurkiewicz/logzio-fluent-bit:latest
    ```

## Advanced

1. Limitation in the logz.io plugin:

    > Logz.io-Out Plugin for Fluent Bit supports one output stream to Logz.io. We plan to add support for multiple streams in the future. In the meantime, we recommend running a new instance for each output stream you need.

    [(from the official logz.io docs)](https://docs.logz.io/shipping/shippers/fluent-bit.html)

2. If you want to load additional custom plugins, you can supply your own plugin.conf by mounting it at `/fluent-bit/etc/plugins.conf`.

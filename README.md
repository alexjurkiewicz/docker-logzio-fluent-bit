# logzio-fluent-bit Docker image

This Docker image is an alternate to [the official Docker image supplied by logz.io](https://docs.logz.io/shipping/shippers/fluent-bit.html).

## Improvements

* Based off the upstream [fluent-bit Dockerfile](https://hub.docker.com/r/fluent/fluent-bit/), which has all default inputs & filters.
  * For example, the `aws` filter is missing from logz.io's image
* Default configuration supplied, only pass in your custom configuration.

## Usage

1. Create a `fluent-bit.conf` file containing your configuration:

    ```ini
    [SYSTEM]
      Log_Level debug

    [INPUT]
        Name tail
        Path /host/var/log/syslog
        DB /host/tmp/logzio-tail-syslog.db

    [FILTER]
        Name aws
        Match *

    [OUTPUT]
        Name logzio
        Match *
        logzio_token ${LOGZIO_TOKEN}
        logzio_type my-logzio-type
        logzio_debug true
    ```

    (You don't need to specify plugin file or load the logzio plugin, that's taken care of.)

2. Run the docker image:

    ```sh
    export LOGZIO_TOKEN=...

    docker run \
      --rm -it \
      -e "LOGZIO_TOKEN" \
      -v "/local/path/to/fluent-bit.conf:/fluent-bit.conf" \
      -v "/:/host" \
      alexjurkiewicz/logzio-fluent-bit
    ```

## Advanced

1.
    > Logz.io-Out Plugin for Fluent Bit supports one output stream to Logz.io. We plan to add support for multiple streams in the future. In the meantime, we recommend running a new instance for each output stream you need.

    [(from the official logz.io docs)](https://docs.logz.io/shipping/shippers/fluent-bit.html)

2. If you want to load additional custom plugins, you can supply your own plugin.conf by mounting it at `/fluent-bit/etc/plugins.conf`.

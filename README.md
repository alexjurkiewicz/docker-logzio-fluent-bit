# logzio-fluent-bit Docker image

This Docker image is an alternate to [the official Docker image supplied by logz.io](https://docs.logz.io/shipping/shippers/fluent-bit.html).

## Improvements

* Based off the upstream [fluent-bit Dockerfile](https://hub.docker.com/r/fluent/fluent-bit/), which has all default inputs & filters.
  * For example, the `aws` filter is missing from logz.io's image
* Default configuration supplied, only pass in your custom configuration.

## Usage

1. Create a `fluent-bit.conf` file containing your configuration. Use [`fluent-bit.conf.example`](fluent-bit.conf.example) as an example.

    (You don't need to specify plugin file or load the logzio plugin, that's taken care of.)

2. Run the docker image:

    ```sh
    # These variables are referenced by the example config
    export LOGZIO_TOKEN=...
    export LOGZIO_TYPE=my-log-type

    docker run \
      --rm -it \
      -e "LOGZIO_TOKEN" -e "LOGZIO_TYPE" \
      -v "/local/path/to/fluent-bit.conf:/fluent-bit.conf" \
      -v "/:/host" \
      alexjurkiewicz/logzio-fluent-bit:latest
    ```

## Advanced

1. Limitation in the logz.io plugin:

    > Logz.io-Out Plugin for Fluent Bit supports one output stream to Logz.io. We plan to add support for multiple streams in the future. In the meantime, we recommend running a new instance for each output stream you need.

    [(from the official logz.io docs)](https://docs.logz.io/shipping/shippers/fluent-bit.html)

2. If you want to load additional custom plugins, you can supply your own plugin.conf by mounting it at `/fluent-bit/etc/plugins.conf`.

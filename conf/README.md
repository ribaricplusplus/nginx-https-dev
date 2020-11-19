# Usage

Configuration is setup so that files in the `src/` directory are processed. If they are regular files,
then they just get copied. If the files in `src/` are M4 files (their file extension is `.m4`), then they will be preprocessed by M4.

`make dev` and `make prod` create a `dist/` directory, which then gets copied into `/etc/nginx` by `sudo make install`.

## Development

~~~
make dev && sudo make install
~~~

## Production

~~~
make prod && sudo make install
~~~

## Check

Check that the produced configuration is valid.

~~~
sudo make check
~~~

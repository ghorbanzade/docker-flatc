# docker-flatc

A basic docker image for flatbuffers compiler

[![Build Status](https://travis-ci.com/ghorbanzade/docker-flatc.svg?branch=master)](https://travis-ci.com/ghorbanzade/docker-flatc)
[![Image Info](https://images.microbadger.com/badges/image/ghorbanzade/flatc.svg)](https://microbadger.com/images/ghorbanzade/flatc)

This work is a simplified version of [neomantra/docker-flatbuffers] by
[Evan Wies] which provides docker tooling for [FlatBuffers].
It enables using **latest released version** of flatbuffers compiler to
generate code from flatbuffers schema file(s) in different languages,
without the need to build the compiler from source
(Read more [here](https://github.com/google/flatbuffers/issues/4374)).
This pattern simplifies the docker-based build process of softwares that
rely on FlatBuffers.

This image is primarily intended to be used as the base of a build
stage of other docker images:

```bash
FROM ghorbanzade/flatc as flatbuffers-builder
COPY --from=previous-build-stage /path/to/schema.fbs .
RUN ./flatc --ts --no-fbs-import schema.fbs
```

It can also be used as a standalone build tool:

```bash
docker run -v ${srcDir}:/opt/src -v ${dstDir}:/opt/dst ghorbanzade/flatc \
    /opt/flatc ${args} -o /opt/dst /opt/src/${schema.fbs}
```

where `srcDir` is the full path to directory on your host machine that
contains flatbuffers schema(s), `dstDir` is the full path to directory
on your host machine into which generated files should be written,
`args` is arguments given to `flatc` executable and `schema.fbs` is the
name of flatbuffers schema file in `srcDir`.

## License

MIT (c) 2018 Pejman Ghorbanzade

[neomantra/docker-flatbuffers]: https://github.com/neomantra/docker-flatbuffers
[Evan Wies]: mailto:evan@neomantra.net
[FlatBuffers]: https://github.com/google/flatbuffers

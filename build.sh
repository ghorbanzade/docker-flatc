#!/bin/bash

# Docker container for Flatbuffers compiler
# https://github.com/ghorbanzade/docker-flatc

set -e
set -o pipefail

fbs_dir="flatbuffers"
fbs_repo="google/flatbuffers"

# download tarball of latest release version from github
curl -s "https://api.github.com/repos/${fbs_repo}/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/' |
    xargs -I {} curl -fsL -o "${fbs_dir}.tar.gz" \
        "https://github.com/${fbs_repo}/archive/"{}'.tar.gz'

# unpack tarball to directory of specified name
mkdir -p ${fbs_dir}
tar zxf "${fbs_dir}.tar.gz" -C ${fbs_dir} --strip-components 1

# build from source
cmake -B${fbs_dir} -H${fbs_dir} \
    -DFLATBUFFERS_BUILD_TESTS=OFF \
    -DFLATBUFFERS_BUILD_FLATHASH=OFF \
    -DFLATBUFFERS_BUILD_FLATC=ON
make -C ${fbs_dir}

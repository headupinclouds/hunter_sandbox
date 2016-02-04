#!/bin/bash

TOOLCHAIN=llvm-osx-linux

EXTRA_ARGS=""
if [ $# -ge 1 ]; then
    EXTRA_ARGS="--clear"
fi

build.py --toolchain ${TOOLCHAIN} --verbose --fwd \
HUNTER_CONFIGURATION_TYPES=Release \
BUILD_EXAMPLES=YES \
CMAKE_VISIBILITY_INLINES_HIDDEN=ON \
CMAKE_CXX_VISIBILITY_PRESET=hidden \
--config Release \
--strip \
--jobs 8 \
${EXTRA_ARGS}

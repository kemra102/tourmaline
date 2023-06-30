#!/usr/bin/env bash

curl -fLo "${PWD}/yadm" https://github.com/TheLocehiliosan/yadm/raw/master/yadm && \
    chmod a+x "${PWD}/yadm" && \
    mv "${PWD}/yadm" /usr/bin/

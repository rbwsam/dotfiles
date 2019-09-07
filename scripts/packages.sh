#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" && cd $DIR

./packages/core.sh

find packages -type f ! -name core.sh -exec {} \;
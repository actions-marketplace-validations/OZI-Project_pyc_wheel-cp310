#!/bin/bash

set -e

# Copy inputs into correctly-named environment variables
export GH_TOKEN="${INPUT_GITHUB_TOKEN}"
export PYTHON_VERSION="${INPUT_PYTHON_VERSION:=$1}"

# Change to configured directory
cd "${INPUT_DIRECTORY}"

# See https://github.com/actions/runner-images/issues/6775#issuecomment-1409268124
# and https://github.com/actions/runner-images/issues/6775#issuecomment-1410270956
git config --system --add safe.directory "*"

case $PYTHON_VERSION in

"3.12")
    export PATH=/root/.pyenv/versions/3.12.2/bin:${PATH}
    ;;

"3.11")
    export PATH=/root/.pyenv/versions/3.11.8/bin:${PATH}
    ;;

"3.10")
    export PATH=/root/.pyenv/versions/3.10.13/bin:${PATH}
    ;;

esac

echo Install pyc_wheel for Python ${PYTHON_VERSION}
python"${PYTHON_VERSION}" -m pip install .

echo Run pyc_wheel for Python ${PYTHON_VERSION}
python"${PYTHON_VERSION}" -m pyc_wheel "${INPUT_FILENAME}"

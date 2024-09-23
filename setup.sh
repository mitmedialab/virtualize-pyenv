#!/bin/bash

if [[ "${BASH_SOURCE-}" != "$0" ]]; then
    echo "You cannot source this script. Run it as ./$0" >&2
    exit 33
fi

DEFAULT_PYTHON_VERSION="3.9.16"

VIRTUALIZE_PYTHON_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE}" )" &> /dev/null && pwd )

if [[ $1 ]]; then
    VIRTUALIZE_PYTHON_VERSION=$1
elif [[ ! $VIRTUALIZE_PYTHON_VERSION ]]; then
    VIRTUALIZE_PYTHON_VERSION=$DEFAULT_PYTHON_VERSION
fi

export PYENV_ROOT="$VIRTUALIZE_PYTHON_DIR/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer > "$VIRTUALIZE_PYTHON_DIR"/pyenv-installer
bash "$VIRTUALIZE_PYTHON_DIR"/pyenv-installer
pyenv install $VIRTUALIZE_PYTHON_VERSION
# set the initial version for pyenv
(cd $VIRTUALIZE_PYTHON_DIR/..; pyenv local $VIRTUALIZE_PYTHON_VERSION)

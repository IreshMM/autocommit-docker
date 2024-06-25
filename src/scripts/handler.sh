#!/usr/bin/bash
SCRIPTS_DIR="${SCRIPTS_DIR:-'/usr/local/scripts'}"
ARGS="$@"

source $SCRIPTS_DIR/functions.sh

sync_target
commit
source /action.sh
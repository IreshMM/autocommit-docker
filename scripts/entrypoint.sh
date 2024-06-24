#!/usr/bin/bash
SCRIPTS_DIR="${SCRIPTS_DIR:-'/usr/local/scripts'}"
ARGS="$@"

source $SCRIPTS_DIR/functions.sh

init
init_sshd
update_authorized_keys
start_sshd

nodemon --exec "$SCRIPTS_DIR/handler.sh" --watch $SOURCE_DIR -e '*' -- $ARGS
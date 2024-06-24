#!/bin/bash
SCRIPTS_DIR="${SCRIPTS_DIR:-'/usr/local/scripts'}"

source $SCRIPTS_DIR/variables.sh

function init() {
    git config --global user.name "nodemon"
    git config --global user.email "nodemon@nodemon"
    git config --global init.defaultBranch "master"
    if [ -z "$(ls -A $TARGET_DIR)" ]; then
        git -C $TARGET_DIR init
    fi
    
    init_sshd
}

function sync_target() {
    rsync --progress -avH --no-relative --exclude '.git' $SOURCE_DIR/ $TARGET_DIR
}

function jenkins_cli() {
    java -jar $JENKINS_CLI -s $JENKINS_URL -auth $JENKINS_USER:$JENKINS_PASS $@
}

function commit() {
    git -C $TARGET_DIR add .
    git -C $TARGET_DIR commit -m "Auto commit"
}

function start_sshd() {
    /usr/sbin/sshd -D -f /home/nodemon/.sshd/sshd_config &
}

function init_sshd() {
    host_key_types=(dsa rsa ecdsa ed25519)
    for key_type in ${host_key_types[@]}; do
        key_path=$HOME/.sshd/ssh_host_${key_type}_key
        echo $key_path
        if [ ! -f $key_path ]; then
            ssh-keygen -t $key_type -f $key_path -N ""
        fi
    done
}

function update_authorized_keys() {
    mkdir -p /home/nodemon/.ssh
    cat /sshkeys/id_rsa.pub >> /home/nodemon/.ssh/authorized_keys
}
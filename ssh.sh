#!/bin/bash

__ssh_algorithm=ed25519
__ssh_file_path=$HOME/.ssh/id_$__ssh_algorithm

sshgen () {
    comment=${1:-zeionara@gmail.com}

    ssh-keygen -t $__ssh_algorithm -C $comment -f $__ssh_file_path

    echo -e '\nPublic key:\n'

    cat $__ssh_file_path.pub
}

alias ssha="cat $__ssh_file_path.pub"

# if [ "$1" == 'no-passphrase' ]; then
#     comment=zeionara@gmail.com
#     passphrase=
# else
#     if [[ -z $2 ]]; then
#         passphrase=$1
#     else
#         comment=$1
#         if [ "$2" == 'no-passphrase' ]; then
#             passphrase=
#         else
#             passphrase=$2
#         fi
#     fi
# fi

# if [ "$2" == 'no-passphrase' ]; then
#     comment=$1
#     passphrase=$2
# else
#     comment=zeionara@gmail.com
#     passphrase=${1:-SSH_PASSPHRASE}
# fi

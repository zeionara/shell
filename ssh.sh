#!/bin/bash

sshgen () {
    comment=${1:-zeionara@gmail.com}
    path=$HOME/.ssh/id_ed25519

    ssh-keygen -t ed25519 -C $comment -f $path

    echo -e '\nPublic key:\n'

    cat $path.pub
}

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

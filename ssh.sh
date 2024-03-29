#!/bin/bash

__ssh_algorithm=ed25519
__ssh_file_path=$HOME/.ssh/id_$__ssh_algorithm

alias ssha="cat $__ssh_file_path.pub"

sshf () {
    user=$1
    host=$2

    src_port=$3
    dst_port=$4

    port=${5:-22}

    ssh -L $dst_port:localhost:$src_port $user@$host -p $port
}

sshgen () {
    comment=${1:-zeionara@gmail.com}

    ssh-keygen -t $__ssh_algorithm -C $comment -f $__ssh_file_path

    echo -e '\nPublic key:\n'

    cat $__ssh_file_path.pub
}

sd5 () { # send to duet 5
    echo scp -P 2217 $1 zeio@d5:~/Downloads/$2
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

#!/bin/bash

name='Zeio Nara'
email='zeionara@gmail.com'

gpgen () {
    gpg2 --version || sudo apt-get install gnupg2

    if [[ -z $1 ]]; then
        gpg2 --quick-generate-key "$name <$email>" rsa4096 cert never
    else
        gpg2 --quick-generate-key "$name ($1) <$email>" rsa4096 cert never
    fi

    key=$(gpg2 --list-secret-keys --keyid-format LONG $email | grep sec | sed 's/.*rsa4096\///' | sed 's/ .*//' | tail -n 1)

    echo -e "\nKey id: $key\n"

    gpg2 --armor --export $key
}

alias gpgl="gpg2 --list-secret-keys --keyid-format LONG $email"
alias gpgenf="gpg2 --full-generate-key"

#!/bin/bash

name='Zeio Nara'
email='zeionara@gmail.com'

gpga () {
    key=$(gpg2 --list-secret-keys --keyid-format LONG $email | grep sec | sed 's/.*rsa4096\///' | sed 's/ .*//' | tail -n 1)

    echo -e "\nKey id: $key\n"

    gpg2 --armor --export $key

    export __GPG_KEY=$key
}

gpgen () {
    # pinentry-tty --version || sudo apt-get update && sudo apt-get install pinentry-tty
    # sudo update-alternatives --set pinentry /usr/bin/pinentry-tty

    # export -e '\nexport GPG_TTY=$(tty)' >> ~/.bashrc

    gpg2 --version || sudo apt-get install gnupg2

    if [[ -z $1 ]]; then
        gpg2 --quick-generate-key "$name <$email>" rsa4096 sign never
    else
        gpg2 --quick-generate-key "$name ($1) <$email>" rsa4096 sign never
    fi

    gpga

    # key=$(gpg2 --list-secret-keys --keyid-format LONG $email | grep sec | sed 's/.*rsa4096\///' | sed 's/ .*//' | tail -n 1)

    # echo -e "\nKey id: $key\n"

    # gpg2 --armor --export $key

    # export __GPG_KEY=$key
}

gpgeng () {
    gpgen $1

    git config --global user.signingkey $__GPG_KEY
    git config --global commit.gpgsign true

    git config --global user.name "$name"
    git config --global user.email "$email"

    git config --global gpg.program gpg2
}

alias gpgl="gpg2 --list-secret-keys --keyid-format LONG $email"

alias gpgenf="gpg2 --full-generate-key"

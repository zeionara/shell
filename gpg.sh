#!/bin/bash

__gpg_user_name='Zeio Nara'
__gpg_user_email='zeionara@gmail.com'

gpga () {
    key=$(gpg2 --list-secret-keys --keyid-format LONG $__gpg_user_email | grep sec | sed 's/.*rsa4096\///' | sed 's/ .*//' | tail -n 1)

    echo -e "\nKey id: $key\n"

    gpg2 --armor --export $key

    export __GPG_KEY=$key
}

gpgen () {
    # Uncomment the following two lines to disable "floating" window for typing passphrase in terminal

    # pinentry-tty --version || sudo apt-get update && sudo apt-get install pinentry-tty
    # sudo update-alternatives --set pinentry /usr/bin/pinentry-tty

    # export -e '\nexport GPG_TTY=$(tty)' >> ~/.bashrc

    gpg2 --version || sudo apt-get install gnupg2

    if [[ -z $1 ]]; then
        gpg2 --quick-generate-key "$__gpg_user_name <$__gpg_user_email>" rsa4096 sign never
    else
        gpg2 --quick-generate-key "$__gpg_user_name ($1) <$__gpg_user_email>" rsa4096 sign never
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

    git config --global user.name "$__gpg_user_name"
    git config --global user.email "$__gpg_user_email"

    git config --global gpg.program gpg2
}

alias gpgl="gpg2 --list-secret-keys --keyid-format LONG $__gpg_user_email"

alias gpgenf="gpg2 --full-generate-key"

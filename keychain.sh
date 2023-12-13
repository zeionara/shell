#!/bin/bash

if [ ! -z $(which keychain | grep -v 'not found') ] && [ ! -z ${GPG_KEY_ID} ]; then
  keychain $HOME/.ssh/id_ed25519
  keychain --agents gpg "$GPG_KEY_ID"

  . $HOME/.keychain/${HOST}-sh
  . $HOME/.keychain/${HOST}-sh-gpg
fi

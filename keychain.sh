#!/bin/bash

if [ ! -z $(which keychain | grep -v 'not found') ] && [ ! -z ${GPG_KEY_ID} ]; then
  keychain --timeout 600 $HOME/.ssh/id_ed25519
  keychain --agents gpg --timeout 600 "$GPG_KEY_ID"

  . $HOME/.keychain/${HOST}-sh
  . $HOME/.keychain/${HOST}-sh-gpg
fi

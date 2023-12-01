#!/bin/bash

keychain --timeout 600 $HOME/.ssh/id_ed25519
keychain --agents gpg --timeout 600 14897B3A5874BA82

. $HOME/.keychain/${HOST}-sh
. $HOME/.keychain/${HOST}-sh-gpg

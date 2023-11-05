#!/bin/bash

set -e

if test ! -d "$HOME/shell"; then
    git clone https://github.com/zeionara/shell.git $HOME/shell
fi

if test -z "$(which zsh 2> /dev/null)"; then
    if test "$(which apt 2> /dev/null)"; then
        sudo apt-get update
        sudo apt-get install zsh
    elif test "$(which emerge 2> /dev/null)"; then
        sudo emerge --sync
        sudo emerge --ask zsh
    else
        sudo pacman -Syu
        sudo pacman -S zsh
    fi
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/marlonrichert/zsh-autocomplete.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/fast-syntax-highlighting"

mv "$HOME/.zshrc" "$HOME/.zshrc.old"
# ln "$HOME/shell/.zshrc" "$HOME/.zshrc"

echo -e '\n. $HOME/shell/.zshrc' >> $HOME/.zshrc

git config --global --replace-all core.pager "less -F -X"

# After installation reopen the sheel, then to activate snuffari theme:
#
# fast-theme "$HOME/shell/snuffari.ini"

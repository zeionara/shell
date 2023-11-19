set -e

if test ! -d "$HOME/shell"; then
    git clone https://github.com/zeionara/shell.git "$HOME/shell"
fi

echo -e '\n. $HOME/shell/.bashrc' >> "$HOME/.bashrc"

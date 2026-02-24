# Shell

<p align="center">
    <img src="assets/images/logo.png"/>
</p>

Useful aliases and scripts for zsh which simplify routine operations.

## Installation

To install the tools execute the following command, which clones the repo to your home directory and updates .bashrc file (for more details see [setup.sh](setup.sh)):

```sh
curl -Ls https://bit.ly/setup-shell | bash
```

To apply changes to your current terminal session, execute the following command:

```sh
. ~/.zshrc
```

## Fix for MacOS

If `MacOS` behaves weirdly over `ssh` connection, the problem might be in the unknown terminal. For enabling `alacritty` support run:

```sh
tic -x <(curl -fsSL https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info)
```

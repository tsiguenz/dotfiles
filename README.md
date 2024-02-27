# Dotfiles

## ***Only tested on parrot.ova***

The script init.sh install and configure neovim, vim, tmux, zsh and alacritty.

After this we need manual things:

- run tmux then CTRL-I to install plugins
- run neovim 2 times to install everything
- logout to reload the new default shell (not usefull if you use alacritty)

---

## How to use

- Clone the project:

```bash
git clone git@github.com:tsiguenz/dotfiles.git && cd dotfiles
```

- Execute the script init.sh:

```bash
./init.sh
```

## TODO

- Delete sudo in the script to run `sudo ./init.sh`
- Delete unused mason things

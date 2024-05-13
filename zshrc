export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)                                                                   
source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"
alias update-discord="sudo apt install $HOME/Downloads/discord-*.deb; rm -rf $HOME/Downloads/discord-*.deb;"
alias cf='p=$(dirname $(fzf)) && cd $p'

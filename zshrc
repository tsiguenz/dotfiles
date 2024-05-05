export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)                                                                   
source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias update-discord="sudo apt install /home/tsiguenz/Downloads/discord-*.deb; rm -rf /home/tsiguenz/Downloads/discord-*.deb;"
alias cf='p=$(dirname $(fzf)) && cd $p'
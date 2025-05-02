# exports
export PATH="$PATH:/Users/iharville/Library/Python/3.11/bin"
export PATH="$PATH:/Applications/Wireshark.app/Contents/MacOS/"
export PATH="/opt/local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# bun (lame)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# aliases
alias code='open /Applications/Visual\ Studio\ Code.app'
alias cpf='copyfile'
alias luamake="/Users/iharville/luamake/luamake"
alias ports='port'
alias gc='gnuradio-companion'

# Starship
eval "$(starship init zsh)"

## Zinit Setup
export ZINIT_HOME="$HOME/.zinit"
source "$HOME/.zinit/zinit.zsh"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust


export PATH="/opt/local/libexec/llvm-8.0/bin:$PATH" # LLVM
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"  # MacPorts

export PATH="$HOME/.local/bin:$HOME/Library/Python/3.11/bin:$PATH"

export PATH="/Applications/Wireshark.app/Contents/MacOS:$PATH" # WireShark CLI

export EDITOR="nvim"
export VISUAL="nvim"

# bun (lame)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# aliases
alias cpf='copyfile'
alias luamake="/Users/iharville/luamake/luamake"
alias ports='port'
alias gc='gnuradio-companion'
alias vim='nvim'
alias vimm='vim'
alias code='open /Applications/Visual\ Studio\ Code.app'

# Starship
eval "$(starship init zsh)"

# pmy
export PMY_TRIGGER_KEY='^I'
eval "$(pmy init)"

# fzf
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom --layout reverse --border top'

# Fuzzy find open for mac
if [[ "$OSTYPE" == darwin* ]]; then
    open() {
      if [[ $# -eq 1 && $1 != -* ]]; then
        local query="$1"
        local -a apps names

        apps=()
        while IFS= read -r -d '' app; do
          apps+=("$app")
        done < <(
          find /Applications /System/Applications "$HOME/Applications" \
            -maxdepth 2 -type d -name '*.app' -print0 2>/dev/null
        )

        # strip paths down to “AppName”
        names=()
        for app in "${apps[@]}"; do
          local base=${app##*/}
          names+=("${base%.app}")
        done

        local chosen
        chosen=$(printf '%s\n' "${names[@]}" \
          | fzf --filter="$query" --select-1 --exit-0)

        if [[ -n $chosen ]]; then
          for app in "${apps[@]}"; do
            local base=${app##*/}
            if [[ "${base%.app}" == "$chosen" ]]; then
              command open -n "$app"
              return
            fi
          done
        fi
      fi

      # fallback
      command open "$@"
    }
fi

## Zinit Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust


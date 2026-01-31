# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
#setopt auto_remove_slash

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
#
bindkey -e

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
#
autoload -U compinit
compinit

## Alias configuration
#
# expand aliases before completing
#
alias ls='ls --color=auto'
setopt complete_aliases # aliased ls needs if file/dir completions work

# npx使用不可に。(pnpxを代わりに使う)
alias npx="echo \"don't use npx\""

# ghqを便利に
function gcd () {
  cd $(ghq list -p | peco --query "$LBUFFER")
}

# for rbenv
eval "$(rbenv init -)"

# for nodenv
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"

# for mise
eval "$(mise activate zsh)"

# for yarn
export PATH="$PATH:`yarn global bin`"

# vimで使いたいだけなので
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# starship
eval "$(starship init zsh)"

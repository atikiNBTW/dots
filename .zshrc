# update if we're in the /dev/tty
if [[ $(tty) =~ "^/dev/tty.*$" ]]; then
    echo -n "Would you like to update? [Y/n] "
    read response

    # If response is empty, set it to "Y"
    if [[ -z "$response" ]]; then
        response="Y"
    fi

    # Convert the response to uppercase
    response=$(echo "$response" | tr 'a-z' 'A-Z')

    if [[ "$response" == "Y" ]]; then
        sudo flatpak update -y && yay -Syu --noconfirm
    fi
else
    fortune | cowsay -f stegosaurus
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# ZInit plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Binds
bindkey '		' autosuggest-accept
bindkey "^[[1;5A" fzf-history-widget
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[1;2A" up-line
bindkey "^[[1;2B" down-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;6C" forward-word
bindkey "^[[1;6D" backward-word
bindkey "^[[3~" delete-char
bindkey "^[[3;2~" delete-char
bindkey "^[[3;6~" delete-char
bindkey -r "^["

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# Aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias update="sudo flatpak update -y && yay -Syu --noconfirm"
alias install="sudo pacman -S "
alias installyay="yay -S "
alias finstall="flatpak install "
alias fixsound="systemctl --user restart wireplumber pipewire pipewire-pulse && sudo systemctl restart bluetooth"
alias cd="z"
alias ls='eza --icons -F -H --group-directories-first --git'
# alias -g monitor="entr -cc "
alias hyprconfig="$EDITOR ~/.config/hypr/hyprland.conf"
alias sctl="systemctl"
alias fixdolphinmime="XDG_MENU_PREFIX=arch- kbuildsycoca6"
alias l="ls -ila"
alias ssh="startSshAgent && ssh "
alias gits="git status"

# Completions
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no # enable fzf-tab menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons -F -H --group-directories-first --git -1 $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza --icons -F -H --group-directories-first --git -1 $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'eza --icons -F -H --group-directories-first --git -1 $realpath'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' switch-group '<' '>'
function _parameters() {} # disable ENV vars completion
zinit cdreplay -q

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
setopt correct
export POWERLEVEL9K_INSTANT_PROMPT=quiet

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=500000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# SSH agent startup
function startSshAgent() {
  if [[ -$parameters[SSH_AGENT_PID]- = *-export-* ]]
  eval "$(ssh-agent -s)" > /dev/null
  echo "WARNING! Started ssh agent!"

  ssh-add ~/.ssh/id_rsa
}

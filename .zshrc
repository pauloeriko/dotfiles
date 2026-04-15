# ─────────────────────────────────────────────
# OH MY ZSH
# ─────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ─────────────────────────────────────────────
# OUTILS
# ─────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
source <(fzf --zsh)

# ─────────────────────────────────────────────
# HISTORIQUE
# ─────────────────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

# ─────────────────────────────────────────────
# VARIABLES D'ENV PERSO
# ─────────────────────────────────────────────
[[ -f ~/.zsh_env ]] && source ~/.zsh_env

# ─────────────────────────────────────────────
# ALIASES — NAVIGATION
# ─────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias lt='eza --tree --level=2 --icons'
alias ll='eza -la --icons --git'
alias la='eza -a --icons'
alias lsize='eza -la --sort=size --icons'

# ─────────────────────────────────────────────
# ALIASES — OUTILS CLI
# ─────────────────────────────────────────────
alias cat='bat --paging=never'
alias grep='rg'
alias http='xh'

# ─────────────────────────────────────────────
# ALIASES — GIT
# ─────────────────────────────────────────────
alias gs='git status'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gpu='git pull'
alias gnb='git checkout -b'
alias gst='git stash'
alias gstp='git stash pop'

# ─────────────────────────────────────────────
# ALIASES — MAINTENANCE
# ─────────────────────────────────────────────
alias editzsh='nano ~/.zshrc && source ~/.zshrc'
alias editssh='nano ~/.ssh/config'
alias edithelpers='nano ~/zsh_helpers.zsh && source ~/zsh_helpers.zsh'
alias reload='source ~/.zshrc'
alias update-all='brew update && brew upgrade && omz update && tldr --update'

# ─────────────────────────────────────────────
# ALIASES — RÉSEAU & API
# ─────────────────────────────────────────────
alias myip='curl -s api.ipify.org && echo'
alias localip="ipconfig getifaddr en0"
alias ports='lsof -iTCP -sTCP:LISTEN -P'

# ─────────────────────────────────────────────
# FONCTIONS — FICHIERS & RECHERCHE
# ─────────────────────────────────────────────
ff() { find . -iname "*${1}*" 2>/dev/null }
ft() { rg "${1}" ${2:+--type $2} }
recent() { find . -mmin -${1:-1440} -type f | sort }
mkcd() { mkdir -p "$1" && cd "$1" }
cpwd() { pwd | pbcopy && echo "Chemin copié" }
dsize() { du -sh "${1:-.}" }

# ─────────────────────────────────────────────
# FONCTIONS — RÉSEAU & API
# ─────────────────────────────────────────────
portcheck() { nc -zv "$1" "$2" 2>&1 }
httpcheck() {
  curl -o /dev/null -s -w "→ %{url_effective}\nCode: %{http_code} | Temps: %{time_total}s | Taille: %{size_download} bytes\n" "$1"
}
api() {
  local method=$1 url=$2 data=$3
  if [[ -n $data ]]; then
    curl -s -X "$method" "$url" \
      -H "Content-Type: application/json" \
      -H "Accept: application/json" \
      -d "$data" | jq .
  else
    curl -s -X "$method" "$url" \
      -H "Accept: application/json" | jq .
  fi
}
serve() { python3 -m http.server ${1:-8000} }

# ─────────────────────────────────────────────
# FONCTIONS — LOGS
# ─────────────────────────────────────────────
logs() {
  if [[ -n $2 ]]; then
    tail -f "$1" | grep --line-buffered -i "$2" | bat --paging=never -l log
  else
    tail -f "$1" | bat --paging=never -l log
  fi
}
logsearch() { rg "$2" "$1" | bat --paging=never -l log }
logsince() {
  local minutes=$1 file=$2
  local since=$(date -v -${minutes}M "+%Y-%m-%d %H:%M")
  awk -v since="$since" '$0 >= since' "$file" | bat --paging=never -l log
}

# ─────────────────────────────────────────────
# FONCTIONS — PROCESSUS
# ─────────────────────────────────────────────
proc() { ps aux | sort -rk 3 | head -20 }
memtop() { ps aux | sort -rk 4 | head -20 }
pfind() { ps aux | rg "$1" }
pkillme() {
  echo "Tuer le processus '$1' ? (o/N)"
  read confirm
  [[ $confirm == "o" ]] && pkill -f "$1" && echo "✓ tué" || echo "Annulé"
}
sysinfo() {
  echo "$(sw_vers -productName) $(sw_vers -productVersion)"
  echo "CPU : $(sysctl -n machdep.cpu.brand_string)"
  echo "RAM : $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) GB"
  echo "Disque : $(df -h / | awk 'NR==2{print $4" libres / "$2}')"
  echo "IP locale : $(ipconfig getifaddr en0)"
}

# ─────────────────────────────────────────────
# FONCTION — NOTE RAPIDE
# ─────────────────────────────────────────────
note() {
  mkdir -p ~/.notes
  nano ~/.notes/$(date +%F).md
}
notes-list() { ls -lt ~/.notes/ | head -10 }

# ─────────────────────────────────────────────
# NOTIFICATIONS (commandes longues > 15s)
# ─────────────────────────────────────────────
_cmd_start_time=$SECONDS
_cmd_name=""
_cmd_start() { _cmd_start_time=$SECONDS; _cmd_name=$1 }
_cmd_notify() {
  local duration=$(( SECONDS - _cmd_start_time ))
  if (( duration > 15 )) && [[ -n $_cmd_name ]]; then
    local cmd_status=$?
    local msg=$([ $cmd_status -eq 0 ] && echo "terminée (${duration}s)" || echo "ERREUR code $cmd_status (${duration}s)")
    osascript -e "display notification \"$_cmd_name — $msg\" with title \"Terminal\""
  fi
  _cmd_name=""
}
preexec() { _cmd_start "$1" }
precmd() { _cmd_notify }

# ─────────────────────────────────────────────
# RAPPELS CONTEXTUELS
# ─────────────────────────────────────────────
_show_reminder() {
  case $1 in
    vim*)    echo "💡 vim : [i] éditer  [Esc] normal  [:wq] sauvegarder  [:q!] forcer quitter" ;;
    nano*)   echo "💡 nano : [^O] sauvegarder  [^X] quitter  [^W] chercher" ;;
    ssh*)    echo "💡 ssh : [exit] quitter  [Enter~.] forcer déco" ;;
    psql*)   echo "💡 psql : [\\q] quitter  [\\dt] tables  [\\d table] structure" ;;
    python3) echo "💡 python : [exit()] ou [Ctrl+D] pour quitter" ;;
  esac
}
preexec_functions=(${preexec_functions:#_show_reminder})
preexec_functions+=(_show_reminder)

# ─────────────────────────────────────────────
# SUGGESTIONS SUR ERREUR
# ─────────────────────────────────────────────
command_not_found_handler() {
  local cmd=$1
  [[ $cmd == "?"* ]] && return 1
  [[ $cmd == "aide"* ]] && return 1
  [[ $cmd == "yazi"* ]] && return 1
  [[ $cmd == "lazygit"* ]] && return 1
  [[ $cmd == "lazydocker"* ]] && return 1
  [[ $cmd == "btop"* ]] && return 1
  case $cmd in
    gti*|got*|gkt*) echo "↪ Tu voulais dire : git ? → ? git pour l'aide" ;;
    dc\ *|dcoker*)  echo "↪ Tu voulais dire : docker ?" ;;
    cat\ *|bat\ *)  echo "↪ Fichier introuvable ? Cherche avec : ff <nom> ou yazi" ;;
    ssh\ *)         echo "↪ Connexion SSH echouee. Verifie ~/.ssh/config" ;;
    *)
      local candidate=$(brew search "^${cmd}$" 2>/dev/null | head -1)
      if [[ -n $candidate ]]; then
        echo "↪ Commande inconnue. Candidat brew : $candidate → brew install $candidate"
      else
        echo "↪ Commande inconnue : $cmd"
      fi
      ;;
  esac
  return 1
}


# ─────────────────────────────────────────────
# AIDE INTÉGRÉE
# ─────────────────────────────────────────────
[[ -f ~/zsh_helpers.zsh ]] && source ~/zsh_helpers.zsh
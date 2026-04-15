aide() {
  local sujet=${1:-""}
  case $sujet in
    git)
      echo "━━━ git ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "gs          git status"
      echo "gl          git log --oneline --graph -20"
      echo "gd          git diff"
      echo "gcm 'msg'   git commit -m 'msg'"
      echo "gp          git push"
      echo "gpu         git pull"
      echo "gnb nom     nouvelle branche"
      echo "gst / gstp  stash / pop"
      echo "lazygit     interface visuelle complète"
      ;;
    docker)
      echo "━━━ docker ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "docker ps              containers actifs"
      echo "docker ps -a           tous les containers"
      echo "docker logs -f <id>    logs en direct"
      echo "docker exec -it <id> bash   entrer dans un container"
      echo "lazydocker             interface visuelle"
      ;;
    ssh)
      echo "━━━ ssh ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "ssh <alias>            connexion"
      echo "ssh -v <alias>         mode debug"
      echo "ssh -L 8080:localhost:80 <host>   tunnel local"
      echo "editssh                éditer ~/.ssh/config"
      echo "Enter ~ .              forcer déconnexion si gelée"
      ;;
    logs)
      echo "━━━ logs ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "logs <fichier>              suivi temps réel"
      echo "logs <fichier> <mot>        suivi avec filtre"
      echo "logsearch <fichier> <texte> chercher dans tout le fichier"
      echo "logsince <minutes> <fichier> logs des N dernières minutes"
      ;;
    réseau|reseau)
      echo "━━━ réseau ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "myip                   IP publique"
      echo "localip                IP locale"
      echo "ports                  ports en écoute"
      echo "portcheck <host> <port> tester un port"
      echo "httpcheck <url>        tester un endpoint HTTP"
      echo "api GET <url>          appel API avec JSON formaté"
      echo "serve [port]           serveur HTTP local (défaut: 8000)"
      ;;
    vim)
      echo "━━━ vim ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "[i]         mode insertion"
      echo "[Esc]       mode normal"
      echo "[:wq]       sauvegarder et quitter"
      echo "[:q!]       quitter sans sauvegarder"
      echo "[/mot]      chercher"
      echo "[u]         annuler"
      ;;
    tmux)
      echo "━━━ tmux ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "tmux              créer/rejoindre session principale"
      echo "Ctrl+A d          détacher"
      echo "tmux attach       reprendre"
      echo "Ctrl+A |          split vertical"
      echo "Ctrl+A -          split horizontal"
      echo "Alt+flèches       naviguer entre panneaux"
      echo "Ctrl+A z          zoom panneau"
      echo "Shift+flèches     changer de fenêtre"
      ;;
    db)
      echo "━━━ base de données ━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "psql              connexion PostgreSQL locale"
      echo "\\l                lister les bases"
      echo "\\c <base>         changer de base"
      echo "\\dt               lister les tables"
      echo "\\d <table>        structure d'une table"
      echo "\\q                quitter"
      ;;
    mise)
      echo "━━━ mise (runtimes) ━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "mise install node@20      installer Node 20"
      echo "mise install python@3.11  installer Python 3.11"
      echo "mise use node@20          utiliser dans ce dossier"
      echo "mise use --global node@20 utiliser globalement"
      echo "mise list                 versions installées"
      ;;
    alias)
      echo "━━━ tous les alias ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      alias | sort
      ;;
    *)
      echo "━━━ aide — sujets disponibles ━━━━━━━━━━━━━━━━━━"
      echo "? git       ? docker    ? ssh       ? logs"
      echo "? réseau    ? vim       ? tmux      ? db"
      echo "? mise      ? alias"
      echo ""
      echo "━━━ commandes rapides ━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "ff <nom>       chercher un fichier"
      echo "ft <texte>     chercher dans les fichiers"
      echo "recent         fichiers modifiés (24h)"
      echo "note           ouvrir la note du jour"
      echo "tldr <cmd>     exemples d'une commande"
      echo "glow <fichier> lire un fichier Markdown"
      echo "btop           moniteur système visuel"
      echo "lazygit        git visuel"
      echo "lazydocker     docker visuel"
      echo "yazi           explorateur de fichiers visuel"
      ;;
  esac
}

alias '?'='aide'

# dotfiles — paul-eric

Setup terminal personnel pour macOS. Thème Tokyo Night custom, orienté dev et homelab.

## Stack

- **Terminal** : Ghostty
- **Shell** : zsh + Oh My Zsh
- **Prompt** : Starship
- **Multiplexeur** : tmux + tmux-resurrect
- **Runtimes** : mise (Node, Python)
- **Env** : direnv

## Installation

```bash
git clone git@github.com:pauloeriko/dotfiles.git ~/sources/dotfiles
cd ~/sources/dotfiles
./install.sh
```

Après installation :
1. Installer Ghostty depuis [ghostty.org](https://ghostty.org)
2. Lancer `tmux` puis `Ctrl+A + Maj+I` pour installer les plugins
3. Relancer le terminal

## Outils installés

| Outil | Remplace | Usage |
|-------|----------|-------|
| `bat` | `cat` | Affichage fichiers avec coloration syntaxe |
| `eza` | `ls` | Listing fichiers avec icônes et statut git |
| `ripgrep` | `grep` | Recherche dans les fichiers |
| `fzf` | historique | Recherche fuzzy interactive (Ctrl+R) |
| `zoxide` | `cd` | Navigation intelligente avec mémoire |
| `jq` | — | Manipulation JSON en ligne de commande |
| `xh` | `curl` | Appels API lisibles |
| `tldr` | `man` | Documentation avec exemples concrets |
| `glow` | — | Rendu Markdown dans le terminal |
| `lazygit` | — | Interface visuelle git |
| `lazydocker` | — | Interface visuelle Docker |
| `btop` | `htop` | Moniteur système visuel |
| `yazi` | — | Explorateur de fichiers avec preview |

## Thème

Tokyo Night custom avec :
- Rouge → Corail `#e06c75`
- Vert → Gris clair `#9aa5b4`
- Police : JetBrains Mono 13px

## Fichiers

```
.zshrc                        config principale du shell
zsh_helpers.zsh               aide intégrée et suggestions sur erreur
.tmux.conf                    config tmux
config/starship/starship.toml config du prompt
config/ghostty/config         config Ghostty
config/ghostty/themes/paul-eric  thème Tokyo Night custom
```

## Aliases principaux

### Git
```bash
gs        git status
gl        git log --oneline --graph
gcm 'msg' git commit -m
gp        git push
gpu       git pull
gnb nom   nouvelle branche
lazygit   interface visuelle
```

### Navigation
```bash
z <nom>   aller dans un dossier visité récemment
ll        listing détaillé avec icônes
lt        arborescence 2 niveaux
yazi      explorateur visuel
```

### Recherche
```bash
ff <nom>      chercher un fichier
ft <texte>    chercher du texte dans les fichiers
recent        fichiers modifiés (24h)
```

### API & Réseau
```bash
api GET <url>         appel API avec JSON formaté
httpcheck <url>       tester un endpoint
serve                 serveur HTTP local port 8000
portcheck <host> <port>  tester un port
```

### Productivité
```bash
note          ouvrir la note du jour
tldr <cmd>    exemples d'une commande
?             aide intégrée
? <sujet>     aide par sujet : git, docker, ssh, logs...
update-all    mettre à jour tous les outils
```

## Mise à jour du repo

Après modification d'un fichier de config :

```bash
cd ~/sources/dotfiles
cp ~/.zshrc .
cp ~/zsh_helpers.zsh .
git add . && git commit -m "update: description" && git push
```

## Notes

- `~/.zsh_env` : credentials et tokens — ne jamais commiter
- `~/.notes/` : notes quotidiennes
- `~/incidents/` : rapports système horodatés

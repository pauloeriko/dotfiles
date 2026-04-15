#!/bin/bash

echo "=== Installation des dotfiles paul-eric ==="

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installation de Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Outils CLI
echo "Installation des outils CLI..."
brew install starship bat eza ripgrep fzf zoxide jq xh tldr glow
brew install lazygit lazydocker btop yazi
brew install git gh mise direnv tmux
brew install zsh-autosuggestions zsh-syntax-highlighting
brew install --cask font-jetbrains-mono

# fzf
$(brew --prefix)/opt/fzf/install --all

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installation de Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Plugins zsh
mkdir -p ~/.oh-my-zsh/custom/plugins
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# tmux plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installation de TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Copie des fichiers de config
echo "Copie des fichiers de config..."
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$DOTFILES_DIR/.zshrc" ~/.zshrc
cp "$DOTFILES_DIR/zsh_helpers.zsh" ~/zsh_helpers.zsh
cp "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf

mkdir -p ~/.config/starship
cp "$DOTFILES_DIR/config/starship/starship.toml" ~/.config/starship.toml

mkdir -p ~/.config/ghostty/themes
cp "$DOTFILES_DIR/config/ghostty/config" ~/.config/ghostty/config
cp "$DOTFILES_DIR/config/ghostty/themes/paul-eric" ~/.config/ghostty/themes/paul-eric

# mise runtimes
echo "Installation des runtimes..."
mise install node@20
mise install python@3.11
mise use --global node@20
mise use --global python@3.11

# Dossiers utilitaires
mkdir -p ~/.notes ~/incidents
touch ~/.zsh_env

echo ""
echo "=== Done ! ==="
echo "1. Ouvre Ghostty et installe la police JetBrains Mono"
echo "2. Lance tmux puis Ctrl+A + Maj+I pour installer les plugins"
echo "3. Relance le terminal"

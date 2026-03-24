#!/bin/bash
set -e

echo "==> Nastavení nového Macbooku"

# 1. Nainstaluj Homebrew, pokud chybí
if ! command -v brew &>/dev/null; then
  echo "==> Instalace Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Přidej brew do PATH pro Apple Silicon
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "==> Homebrew již je nainstalováno"
fi

# 2. Aktualizuj brew
echo "==> Aktualizace Homebrew..."
brew update

# 3. Nainstaluj vše z Brewfile
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "==> Instalace aplikací z Brewfile..."
brew bundle --file="$SCRIPT_DIR/Brewfile"

echo ""
echo "==> Hotovo! Restartuj terminál."

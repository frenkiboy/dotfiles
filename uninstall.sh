#!/usr/bin/env bash
# Remove dotfile symlinks pointing into this repo. Backups are left in place.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FILES=(bashrc bash_profile profile vimrc tmux.conf gitconfig inputrc)

unlink_if_ours() {
  local dst="$1" src="$2"
  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
    rm "$dst"
    echo "  rm   $dst"
  else
    echo "  skip $dst (not a symlink to this repo)"
  fi
}

for f in "${FILES[@]}"; do
  unlink_if_ours "$HOME/.$f" "$DOTFILES/$f"
done

for d in autoload ftdetect ftplugin syntax; do
  unlink_if_ours "$HOME/.vim/$d" "$DOTFILES/vim/$d"
done

echo "Done. *.backup-* files in \$HOME are left in place."

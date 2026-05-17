#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME.
# Existing non-symlink targets are backed up to <target>.backup-YYYYMMDD-HHMMSS.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

# bare-name -> $HOME/.bare-name
FILES=(bashrc bash_profile profile vimrc tmux.conf gitconfig)

link() {
  local src="$1" dst="$2"
  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
    echo "  ok   $dst"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mv "$dst" "$dst.backup-$STAMP"
    echo "  bak  $dst -> $dst.backup-$STAMP"
  fi
  ln -s "$src" "$dst"
  echo "  link $dst -> $src"
}

echo "Installing dotfiles from $DOTFILES"

for f in "${FILES[@]}"; do
  link "$DOTFILES/$f" "$HOME/.$f"
done

# vim subdirectories: symlink each so existing ~/.vim/plugged/ (vim-plug) is untouched
mkdir -p "$HOME/.vim"
for d in autoload ftdetect ftplugin syntax; do
  if [[ -d "$DOTFILES/vim/$d" ]]; then
    link "$DOTFILES/vim/$d" "$HOME/.vim/$d"
  fi
done

cat <<MSG

Done. Open a new shell or run:  source ~/.bashrc

Next steps:
  - vim plugins:    vim +PlugInstall +qall      # rebuilds ~/.vim/plugged/
  - tmux reload:    tmux source ~/.tmux.conf    # if inside tmux
  - directory marks: bookmarks live in \$MARKPATH (~/.marks) and are per-machine
MSG

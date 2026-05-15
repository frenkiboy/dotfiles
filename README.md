# dotfiles

Personal shell + editor configuration. Installs via symlinks, so edits to the live files in `$HOME` flow back to the repo.

## Setup on a new machine

```bash
git clone <repo-url> ~/Utils/dotfiles
cd ~/Utils/dotfiles
./install.sh
```

The installer symlinks each bare-name file into `$HOME/.<name>`. If a target file already exists and isn't already a symlink to this repo, it is backed up as `<target>.backup-YYYYMMDD-HHMMSS`. Re-running `install.sh` is idempotent.

Then:

```bash
source ~/.bashrc            # or open a new shell
vim +PlugInstall +qall      # rebuilds ~/.vim/plugged/ via vim-plug (only first time)
```

## What's included

| File | Target | Notes |
|---|---|---|
| `bashrc` | `~/.bashrc` | aliases, PATH, prompt, **directory bookmarks** (`mark`/`unmark`/`marks`/`jump` with tab completion via `_completemarks`), `clauded`/`claudedc` shortcuts, `sbr`, `tt`/`tls`/`tlc`, `cc`, etc. |
| `bash_profile` | `~/.bash_profile` | login-shell entry point |
| `profile` | `~/.profile` | POSIX-shell entry point |
| `vimrc` | `~/.vimrc` | vim config (vim-plug bootstrap) |
| `tmux.conf` | `~/.tmux.conf` | tmux config |
| `gitconfig` | `~/.gitconfig` | git user/aliases |
| `inputrc` | `~/.inputrc` | readline bindings |
| `vim/autoload/` | `~/.vim/autoload/` | vim-plug installer |
| `vim/ftdetect/` | `~/.vim/ftdetect/` | filetype detection rules |
| `vim/ftplugin/` | `~/.vim/ftplugin/` | per-filetype settings |
| `vim/syntax/` | `~/.vim/syntax/` | custom syntax files |

`~/.vim/plugged/` is **not** tracked — vim-plug rebuilds it from `~/.vimrc` on first launch.

## Directory bookmarks

`bashrc` defines four per-shell bookmarking helpers and a tab-completion source:

```
mark <name>      # create symlink ~/.marks/<name> -> $(pwd)
unmark <name>    # delete that symlink (with prompt)
marks            # list all marks
jump <name>      # cd to that mark
```

The marks themselves live in `$MARKPATH` (`~/.marks/`) and are **per-machine** — they aren't synced by this repo.

## Uninstall

```bash
./uninstall.sh
```

Removes only the symlinks pointing at this repo. Any `*.backup-*` files in `$HOME` are left in place; restore them by hand if you want the original back.

## Updating

Files are symlinks, so editing `~/.bashrc` edits `~/Utils/dotfiles/bashrc`. Commit and push from `~/Utils/dotfiles` as usual.

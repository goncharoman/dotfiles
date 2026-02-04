set fish_greeting

# preload ~/.profile
# required to load basic env configuration
if test -e $HOME/.profile
    source $HOME/.profile
end

# XDG paths
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_BIN_DIR $HOME/.local/bin
set -gx XDG_RUNTIME_DIR $HOME/.runtime
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

# Homebrew setup
set -gx HOMEBREW_AUTO_UPDATE_SECS 86400

# rustup (and cargo) setup
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo

# golang setup
set -gx GOENV_ROOT $XDG_DATA_HOME/goenv
set -gx GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
set -gx GOENV_RC_FILE $XDG_CONFIG_HOME/goenv/goenvrc
set -gx GOENV_PATH_ORDER front

# ghcup setup
set -gx GHCUP_USE_XDG_DIRS true

# npm setup
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx NPM_CONFIG_INIT_MODULE $XDG_CONFIG_HOME/npm/config/npm-init.js
set -gx NPM_CONFIG_TMP $XDG_RUNTIME_DIR/npm

# pass setup
set -gx PASSWORD_STORE_DIR $XDG_DATA_HOME/pass

# gpg (aka gnupg) setup
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg

# psql setup
set -gx PSQLRC $XDG_CONFIG_HOME/pg/psqlrc
set -gx PSQL_HISTORY $XDG_STATE_HOME/psql_history

# pyenv setup
set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv

# sqlite setup
set -gx SQLITE_HISTORY $XDG_CACHE_HOME/sqlite_history

# terminfo setup
set -gx TERMINFO $XDG_DATA_HOME/terminfo
set -gx TERMINFO_DIRS $TERMINFO:/usr/share/terminfo

# w3m setup
set -gx W3M_DIR $XDG_DATA_HOME/w3m

# poetry setup (using XDG paths)
set -gx POETRY_HOME $XDG_DATA_HOME/pypoetry
set -gx POETRY_CONFIG_DIR $XDG_CONFIG_HOME/pypoetry
set -gx POETRY_CACHE_DIR $XDG_CACHE_HOME/pypoetry

# stack (haskell) setup
set -gx STACK_XDG true

# eza (replacement ls) setup
set -gx EZA_CONFIG_DIR $XDG_CONFIG_HOME/eza

# added ~/.local/bin (user's locals bin) into PATH
if not contains $XDG_BIN_DIR $PATH
    set -gx PATH $XDG_BIN_DIR $PATH
end

# set Neovim as the default editor (for git and etc.).
set -gx EDITOR nvim

# set less as the default pager (for git-log and etc.).
set -gx PAGER 'less -+FX -S'

# this fixed an issue with displaying Python venv in Starship
set -gx VIRTUAL_ENV_DISABLE_PROMPT true

# initialize tools (setup shell)
$HOMEBREW_HOME/bin/brew shellenv | source
starship init fish | source
pyenv init - fish | source
goenv init - fish | source
luarocks path --bin | source
source $CARGO_HOME/env.fish

# apple keychain setup
ssh-add --apple-load-keychain &>/dev/null

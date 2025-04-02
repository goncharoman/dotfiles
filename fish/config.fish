set fish_greeting

# preload ~/.profile
if test -e $HOME/.profile
  source $HOME/.profile
end


# XDG
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_RUNTIME_DIR $HOME/.runtime
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

# Homebrew 
set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
if test -z "HOMEBREW_HOME"
  set -gx HOMEBREW_HOME /opt/homebrew
end

# go
set -gx GOPATH $XDG_DATA_HOME/go
set -gx GOENV_ROOT $XDG_DATA_HOME/goenv

# npm
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx NPM_CONFIG_INIT_MODULE $XDG_CONFIG_HOME/npm/config/npm-init.js
set -gx NPM_CONFIG_TMP $XDG_RUNTIME_DIR/npm

# pass
set -gx PASSWORD_STORE_DIR $XDG_DATA_HOME/pass

# psql
set -gx PSQLRC $XDG_CONFIG_HOME/pg/psqlrc
set -gx PSQL_HISTORY $XDG_STATE_HOME/psql_history

# pyenv
set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv

# sqlite
set -gx SQLITE_HISTORY $XDG_CACHE_HOME/sqlite_history

# terminfo
set -gx TERMINFO $XDG_DATA_HOME/terminfo
set -gx TERMINFO_DIRS $TERMINFO:/usr/share/terminfo

# w3m
set -gx W3M_DIR $XDG_DATA_HOME/w3m

# poetry
set -gx POETRY_HOME $XDG_DATA_HOME/pypoetry
set -gx POETRY_CONFIG_DIR $XDG_CONFIG_HOME/pypoetry
set -gx POETRY_CACHE_DIR $XDG_CACHE_HOME/pypoetry

# PATH
set -g fish_user_paths $HOMEBREW_HOME/bin $fish_user_paths
set -g fish_user_paths $HOMEBREW_HOME/sbin $fish_user_paths
set -g fish_user_paths $PYENV_ROOT/bin $fish_user_paths
set -g fish_user_paths $GOENV_ROOT/bin $fish_user_paths
set -g fish_user_paths $POETRY_HOME/bin $fish_user_paths


starship init fish | source
pyenv init - fish | source
goenv init - fish | source

ssh-add --apple-load-keychain &> /dev/null

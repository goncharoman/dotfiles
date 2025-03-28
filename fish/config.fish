set fish_greeting

# paths
set -g fish_user_paths /opt/homebrew/bin $fish_user_paths
set -g fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# XDG config
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_RUNTIME_DIR $HOME/.runtime
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx GOPATH $XDG_DATA_HOME/go
set -gx GOENV_ROOT $XDG_DATA_HOME/goenv
set -gx NB_DIR $XDG_DATA_HOME/nb
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx NPM_CONFIG_INIT_MODULE $XDG_CONFIG_HOME/npm/config/npm-init.js
set -gx NPM_CONFIG_TMP $XDG_RUNTIME_DIR/npm
set -gx PASSWORD_STORE_DIR $XDG_DATA_HOME/pass
set -gx PSQLRC $XDG_CONFIG_HOME/pg/psqlrc
set -gx PSQL_HISTORY $XDG_STATE_HOME/psql_history
set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv
set -gx SQLITE_HISTORY $XDG_CACHE_HOME/sqlite_history
set -gx TERMINFO $XDG_DATA_HOME/terminfo
set -gx TERMINFO_DIRS $TERMINFO:/usr/share/terminfo
set -gx W3M_DIR $XDG_DATA_HOME/w3m

set -gx HOMEBREW_AUTO_UPDATE_SECS 86400

starship init fish | source
pyenv init - fish | source
goenv init - | source

ssh-add --apple-load-keychain &> /dev/null

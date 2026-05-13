set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_BIN_DIR $HOME/.local/bin
set -gx XDG_RUNTIME_DIR $HOME/.runtime
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

if not contains $XDG_BIN_DIR $PATH
    set -gx PATH $XDG_BIN_DIR $PATH
end

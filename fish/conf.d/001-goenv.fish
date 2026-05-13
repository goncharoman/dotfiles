set -gx GOENV_ROOT $XDG_DATA_HOME/goenv
set -gx GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
set -gx GOENV_RC_FILE $XDG_CONFIG_HOME/goenv/goenvrc
set -gx GOENV_PATH_ORDER front

if status --is-login
    goenv init - fish | source
end

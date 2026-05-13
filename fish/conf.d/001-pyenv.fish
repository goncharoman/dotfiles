set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv

if status --is-login
    pyenv init - fish | source
end

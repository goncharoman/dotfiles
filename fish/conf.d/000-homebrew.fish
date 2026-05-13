if status --is-login
    set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
    /opt/homebrew/bin/brew shellenv | source
end

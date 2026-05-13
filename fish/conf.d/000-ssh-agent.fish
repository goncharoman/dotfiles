if status --is-login
    eval $(ssh-agent -c) &>/dev/null
    ssh-add --apple-load-keychain &>/dev/null
end

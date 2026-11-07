function remacs --description 'Restart the Emacs daemon (user service)'
    systemctl --user restart emacs.service $argv
end



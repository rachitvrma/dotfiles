function fish_user_key_bindings
    if test "$fish_key_bindings" = fish_vi_key_bindings
        bind -M insert ! __history_previous_command
        bind -M insert '$' __history_previous_command_arguments
    else
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments
    end
end



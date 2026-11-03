function copy
    if test (count $argv) -eq 2; and test -d $argv[1]
        command cp -r (string trim --right --chars=/ -- $argv[1]) $argv[2]
    else
        command cp $argv
    end
end



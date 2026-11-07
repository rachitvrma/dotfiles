# Export XDG_*_DIR from ~/.config/user-dirs.dirs. That file is shell syntax,
# which fish cannot source, so parse it. Counterpart of 05-xdg-userdirs.bashrc.
set -l ud $XDG_CONFIG_HOME/user-dirs.dirs
test -r $ud; or return

# Regex, explained piece by piece:
#   ^                 start of the line (skips commented lines)
#   (XDG_[A-Z]+_DIR)  capture group 1: the literal text XDG_, one or more
#                     capital letters, then the literal text _DIR
#   ="                a literal equals sign and opening double quote
#   (.*)              capture group 2: everything up to the closing quote
#   "$                the closing double quote at the end of the line
# -r means regex and -g prints only the capture groups, so the output
# alternates: name, value, name, value, ...
set -l kv (string match -rg '^(XDG_[A-Z]+_DIR)="(.*)"$' <$ud)
for i in (seq 1 2 (count $kv))
    set -gx $kv[$i] (string replace -- '$HOME' $HOME $kv[(math $i + 1)])
end



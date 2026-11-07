# PATH. Final order: ~/.local/bin, ~/bin, cargo bin (first argument wins).
# fish_add_path ignores directories that do not exist; -g keeps it declarative
# (no universal variable written to fish_variables), -m moves duplicates up.
fish_add_path -g -m $HOME/.local/bin $HOME/bin $CARGO_HOME/bin

# Go: binaries install to $GOBIN if set, otherwise $GOPATH/bin (default ~/go/bin).
# Appended (-a), like dot-bashrc, so it never shadows system binaries.
# (set -l inside an if block would be local to that block, so declare first.)
set -l gobin $HOME/go/bin
if set -q GOBIN
    set gobin $GOBIN
else if set -q GOPATH
    set gobin $GOPATH/bin
end
fish_add_path -g -a $gobin



# Facts used by many modules. Every flake-parts module can take them as the
# `me` argument:  { me, ... }: { ... me.username ... }
# NixOS modules defined inside such a file see it through closure.
{
  _module.args.me = {
    username = "krish";
    fullName = "Rachit Kumar Verma";
  };
}

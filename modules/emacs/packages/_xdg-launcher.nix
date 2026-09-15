{
  melpaBuild,
  lib,
  fetchFromGitHub,
}:
melpaBuild {
  pname = "xdg-launcher";
  version = "0-unstable-2026-09-14";

  src = fetchFromGitHub {
    owner = "emacs-exwm";
    repo = "xdg-launcher";
    rev = "78c591df0a87cbabcfd65788546233dca6f2018d"; # main, as of packaging
    # hash = lib.fakeHash; # `nix build` will fail and print the real hash; paste it in here
    hash = "sha256-zZ+ndsgGUv30wlA9RcvCJCY5D3Upz9m/5wLtz9fyi3w=";
  };

  # No packageRequires: the sole dependency is Emacs 28.1+ itself
  # (nerd-icons/consult integration in the package is soft, feature-guarded).

  meta = {
    description = "Dmenu-style XDG application launcher for Emacs's minibuffer";
    homepage = "https://github.com/emacs-exwm/xdg-launcher";
    license = lib.licenses.gpl3Plus;
    maintainers = [ ];
  };
}

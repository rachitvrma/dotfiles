<h1 align="center">
    <div align="center">
        <img src="./.github/images/nixos.svg" width="100px"/>
    </div>
    <br>
    <p>Rachit's NixOS configuration</p>
    <img src="https://capsule-render.vercel.app/api?type=waving&height=300&color=0:cba6f7,100:89b4fa&text=Rachit's%20nixdots&fontColor=1e1e2e&fontAlign=50&fontAlignY=38&fontSize=48&animation=fadeIn&desc=NixOS%20%C2%B7%20Home-Manager%20%C2%B7%20Niri&descAlign=50&descAlignY=62&descSize=18&descColor=1e1e2e" />
    <div align="center">
        <p></p>
        <div align="center">
            <a href="https://neovim.io/">
                <img src="https://img.shields.io/badge/v0.12.4-green?style=for-the-badge&logo=neovim&logoColor=a6e3a1&label=neovim&labelColor=1e1e2e&color=a6e3a1">
            </a>
            <a href="https://niri-wm.github.io/niri/index.html">
                <img src="https://img.shields.io/badge/26.04%20(Nixpkgs)-orange?style=for-the-badge&logo=niri&logoColor=fab387&label=niri&labelColor=1e1e2e&color=fab387">
            </a>
            <a href="https://nixos.org">
                <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=NixOS&logoColor=89b4fa&color=89b4fa">
            </a>
            <a href="https://github.com/rachitvrma/nixdots/blob/main/LICENSE">
                <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPL&colorA=1e1e2e&colorB=cba6f7&logo=unlicense&logoColor=f9e2af&%22"/>
            </a>
        </div>
        <br>
    </div>
</h1>

## Introduction

> [!NOTE]
> Looks matter. It is a good thing to have utility with a good rice.

| Util                    | Program used                        |
| ----------------------- | ----------------------------------- |
| Shell                   | Fish                                |
| WM/DE                   | Niri                                |
| Editor                  | Neovim                              |
| Terminal                | Kitty                               |
| Audio                   | RMPC + MPD                          |
| System Monitor          | Bottom                              |
| Mail                    | _still wip_                         |
| File Manager (GUI)      | PCManFM                             |
| File Manager (TUI)      | Yazi                                |
| RSS Reader              | MiniFlux (WebUI) + Eilmeldung (TUI) |
| Theme                   | Rose Pine                           |
| Browser (GUI)           | Firefox/QuteBrowser (I use both)    |
| Text Browser (Terminal) | w3m                                 |
| Agenda/Task Maintainer  | taskwarrior                         |

---
## Instructions for Installation:

>[!note]
>I am assuming that an ISO is already created.
>for more details see the [NixOS Manual](https://nixos.org/manual/nixos/stable/)


### 🧪 Enable Experimental Features

Experimental features are not enabled in NixOS by default. They can be
enabled by exporting the `NIX_CONFIG` variable or by passing the
`--extra-experimental-features` flag to the `nix` command utility.

First, enter into a root shell:

```bash
sudo -i
```

Run this to enable flakes and the nix-command utility:

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

### ↙️ Clone this Repo

Clone the repository into `/tmp`:

```bash
mkdir -p /tmp
cd /tmp
git clone --depth=1 https://github.com/rachitvrma/nixdots.git
```

### 💾 Run Disko to Prepare Disks

Disko is available in [nixpkgs](https://github.com/NixOS/nixpkgs), but
it is advisable to run the latest commit from the
[nix-community](https://github.com/nix-community/disko) repo. Make sure
the `disko-config.nix` belongs to the correct host. By default, it's set
for [nixpavilion](./modules/hosts/nixpavilion).

```bash
cd /tmp/nixdots/modules/hosts/nixpavilion
nix run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko-config.nix
```

### 🐧 OS Installation

Copy the cloned repo into `/mnt/etc/nixos` and run the installation:

```bash
mkdir -p /mnt/etc
cp -r /tmp/nixdots /mnt/etc/nixos
nixos-install --no-root-passwd --root /mnt --cores 8 --max-jobs 1 --flake /mnt/etc/nixos#nixpavilion
```

Reboot after unmounting:

```bash
umount -R /mnt
reboot
```

### 💻 Post-OS-Installation

#### 🔒 Change user password

```bash
passwd $USER
```

#### ✏️ Editing NixOS configuration without `sudo`
Move `/etc/nixos` to `$HOME/etc/nixos` so that the user can edit NixOS configuration files without `sudo`. [Taken from the wiki](https://wiki.nixos.org/wiki/NixOS_configuration_editors#Editing_as_normal_user).

```bash
mkdir ~/etc
sudo mv /etc/nixos ~/etc/
sudo chown -R $(id -un):users ~/etc/nixos
sudo ln -s ~/etc/nixos /etc/
```

#### 📰 Miniflux setup

To set up miniflux for RSS feeds

```bash
sudo mkdir -p /etc/secrets/miniflux-admin-credentials
sudo chmod 600 /etc/secrets/miniflux-admin-credentials
```

In that file put:
```txt
ADMIN_USERNAME=<username>
ADMIN_PASSWORD=something6charactersLong
```

## Nix / NixOS / Flakes

### The book from Reddit

- **[NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)** — ryan4yin. Covers flake-parts-adjacent patterns, home-manager, and NixOS
  module system in depth. GitHub: <https://github.com/ryan4yin/nixos-and-flakes-book>

### Official / foundational docs

- **[nix.dev](https://nix.dev/)** — the official "get things done" guide, opinionated
  and task-oriented rather than reference-only.
- **[Nix Reference Manual](https://nix.dev/manual/nix/stable/)** — the actual
  language/CLI spec. Dry, but authoritative when nix.dev hand-waves something.
- **[Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/)** and
  **[NixOS Manual](https://nixos.org/manual/nixos/stable/)** — same deal, one
  level down the stack.
- **[Nix Pills](https://nixos.org/guides/nix-pills/)** — the classic "build up
  Nix from first principles" series. Old but still the best mental-model builder
  for _why_ Nix works the way it does, not just how to invoke it.

### Flake-centric / modern onboarding

- **[Zero to Nix](https://zero-to-nix.com/)** — Determinate Systems' flakes-first
  onboarding guide. Good "quick start" track plus per-language dev-shell guides.
- **[Nix from First Principles: Flake Edition](https://christitus.com/)** style
  crash-courses — search for the current top hit, these get updated often.
- **Wombat's Book of Nix** — another book-length intro, more concept-first than
  ryan4yin's, good second opinion when something doesn't click.

### Reference / search tools (bookmark these, you'll use them constantly)

- **[Noogle](https://noogle.dev/)** — Nix API search by function signature/type.
  Genuinely the fastest way to find a `lib.*` function when you know the shape
  you want but not the name.
- **[Home Manager Option Search](https://home-manager-options.extranix.com/)** —
  searchable index of all HM options, faster than grepping the manual.
- **[search.nixos.org](https://search.nixos.org/)** — packages + NixOS options.
- **[Searchix](https://searchix.dev/)** / **NüschtOS Search** — alternative
  option search engines, sometimes surface things the official search misses.
- **[MyNixOS](https://mynixos.com/)** — another options/packages search, decent
  UI for cross-referencing multiple option sources at once.

### Curated meta-lists (better than any single page)

- **[awesome-nix](https://github.com/nix-community/awesome-nix)** — the
  community-maintained master list. Sections for language tooling, deployment,
  learning resources, dev-shell frameworks (flake-parts, flake-utils, dream2nix,
  flakelight, etc.). Worth periodically re-skimming as things move fast here.
- **[Nix Shorts](https://github.com/justinwoo/nix-shorts)** — short focused
  write-ups on specific Nix idioms, updated for flakes.
- **[How to Learn Nix](https://ianthehenry.com/posts/how-to-learn-nix/)** —
  Ian Henry's "let's-play"-style walkthrough of the language semantics
  specifically (not NixOS, not flakes — just the _language_, which is usually
  the part people skip and regret).

### Video

- **[Nix in 100 Seconds (Fireship)](https://www.youtube.com/watch?v=Pj_th-Vqvz4)** —
  not depth, but a good 100-second gut-check to send to anyone asking what Nix is.
- Search current channels for **"vimjoyer"** and **"ryan4yin"** on YouTube —
  both do NixOS/flake-parts/home-manager walkthroughs pretty regularly; check
  what's recent since the corpus of videos changes often.
---

## 📃 License

This project is licensed under the GNU General Public License v3.0. See
the [LICENSE](../LICENSE) file for details.

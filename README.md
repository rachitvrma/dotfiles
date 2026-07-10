# My NixOS configuration


---

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
  for *why* Nix works the way it does, not just how to invoke it.

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
  specifically (not NixOS, not flakes — just the *language*, which is usually
  the part people skip and regret).

### Video
- **[Nix in 100 Seconds (Fireship)](https://www.youtube.com/watch?v=Pj_th-Vqvz4)** —
  not depth, but a good 100-second gut-check to send to anyone asking what Nix is.
- Search current channels for **"vimjoyer"** and **"ryan4yin"** on YouTube —
  both do NixOS/flake-parts/home-manager walkthroughs pretty regularly; check
  what's recent since the corpus of videos changes often.

---

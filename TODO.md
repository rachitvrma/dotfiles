# Tasks

- [ ] File a PR on Firefox's derivation. See [Firefox's module.nix](./modules/firefox.nix).
- [ ] Create a Cava themes module. See [cava's module](./modules/packages.nix).
- [ ] Create a home-manager module for [hyprtoolkit.conf](https://wiki.hypr.land/Hypr-Ecosystem/hyprtoolkit/).
- [ ] Version bump Gophertube in nixpkgs.
- [ ] Write a module to export NNN environment variables along with the nnn homeManager module.
- [ ] Contribute [yamb.yazi](https://github.com/h-hg/yamb.yazi) to nixpkgs.
- [ ] Configure markdown_oxide for PKM-style notes.
- [ ] Fix mpd's home-manager module, see [multimedia](./modules/multimedia.nix)
- [ ] Configure printing in nixpavilion
- [ ] Write a module for timewarrior (maybe)
- [ ] Write rmpc's theme module
- [ ] Configure zk-cli for zettelkasten notes.
- [ ] Learn lazyjj
- [ ] Learn why lazyworktree's `lwt` shell-wrapper name isn't working.

## Fix lazyworktree's shell integration.

````txt
Confirmed exactly. `--code` errors with `flag provided but not defined: -code`, and urfave/cli's error handler prints the subcommand's help instead of failing loudly — that help text is what `installShellCompletion` captured into `$out/share/fish/vendor_completions.d/lazyworktree.fish`. Mystery fully solved.

You now have everything needed for a tight, unambiguous nixpkgs PR:

**The fix** — `pkgs/by-name/la/lazyworktree/package.nix`:

```nix
installShellCompletion --cmd lazyworktree \
  --bash <($out/bin/lazyworktree completion bash) \
  --zsh <($out/bin/lazyworktree completion zsh) \
  --fish <($out/bin/lazyworktree completion fish)
````

Just remove `--code` from all three lines (worth quickly checking bash/zsh the same way you just did for fish, to confirm they're broken identically — I'd expect so, since it's the same unrecognized-flag mechanism, but two seconds to verify beats an assumption in a PR description).

**PR description essentially writes itself:**

- Repro: `lazyworktree completion fish --code` → `flag provided but not defined: -code`, and instead of failing the build, `installShellCompletion`'s process substitution silently captures the resulting help-text fallback into the vendored completion file.
- Effect: sourcing the installed fish (and likely bash/zsh) completions throws `command not found` errors for `NAME:`, `USAGE:`, etc., since the captured content is plain help text, not a valid completion script.
- Fix: drop the unsupported `--code` flag; `lazyworktree completion <shell>` alone produces the correct script (verified directly against the built binary).

One nuance worth adding to the PR body: it'd also be worth flagging to `doInstallCheck`/`versionCheckHook` maintainers that this class of bug — a flag error silently degrading into help-text rather than a nonzero exit that'd fail the build — snuck past CI. That's arguably also worth a one-line upstream note to `chmouel/lazyworktree` itself (via an issue), since `urfave/cli` swallowing a flag error into a help dump rather than a hard failure is exactly the sharp edge that let this ship unnoticed in the first place. Not blocking your nixpkgs fix, but a natural companion issue given you've already done the legwork to isolate it.

```
```

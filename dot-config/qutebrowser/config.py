config.load_autoconfig(False)
config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("completion.height", "30%")
config.set("content.blocking.whitelist", [])
config.set("content.javascript.modal_dialog", True)
config.set("editor.command", ["emacsclient", "-c", "--alternate-editor=", "{}"])
config.set("fonts.default_family", "JetBrainsMono Nerd Font")
config.set("fonts.default_size", "12pt")
config.set("fonts.web.family.cursive", "JetBrainsMono Nerd Font")
config.set("fonts.web.family.fantasy", "JetBrainsMono Nerd Font")
config.set("fonts.web.family.fixed", "JetBrainsMono Nerd Font")
config.set("fonts.web.family.sans_serif", "JetBrainsMono Nerd Font")
config.set("fonts.web.family.serif", "JetBrainsMono Nerd Font")
config.set("fonts.web.family.standard", "JetBrainsMono Nerd Font")
config.set("fonts.web.size.default", 16)

c.url.searchengines['aw'] = "https://wiki.archlinux.org/?search={}"
c.url.searchengines['g'] = "https://www.google.com/search?hl=en&q={}"
c.url.searchengines['no'] = "https://search.nixos.org/options?channel=unstable&query={}"
c.url.searchengines['np'] = "https://search.nixos.org/packages?channel=unstable&query={}"
c.url.searchengines['nw'] = "https://wiki.nixos.org/index.php?search={}"
c.url.searchengines['w'] = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1"
c.url.searchengines['yt'] = "https://www.youtube.com/results?search_query={}"
c.url.searchengines['ytm'] = "https://music.youtube.com/results?search_query={}"

# Load noctalia colors
config.source('noctalia/colors.py')

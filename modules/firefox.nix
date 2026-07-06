{
  flake.homeModules.firefox =
    {
      config,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        # TODO: there's something wrong with the ln command in the derivation here
        # See todo.org
        # pkcs11Modules = [ pkgs.p11-kit ];

        policies =
          let
            extension = shortId: guid: {
              name = guid;
              value = {
                install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "force_installed";
                private_browsing = true;
              };
            };
            extensions = [
              # To add additional extensions, find it on addons.mozilla.org, find
              # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
              # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
              (extension "ublock-origin" "uBlock0@raymondhill.net")
              # ...
            ];
          in
          {
            DisableTelemetry = true;
            ExtensionSettings = {
              "*".installation_mode = "blocked";
            }
            // (builtins.listToAttrs extensions);
            DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
            SearchEngines = {
              Default = "DuckDuckGo";
              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }
              ];
            };
          };
        profiles.krish = {
          isDefault = true;
          id = 0;
          name = "krish";
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "extensions.autoDisableScopes" = 0;

            # For xdg-desktop-portal-termfilechooser
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "widget.use-xdg-desktop-portal.open-uri" = 1;

            # https://wiki.nixos.org/wiki/COSMIC#Theming_and_Firefox
            "widget.gtk.libadwaita-colors.enabled" = false;

            "devtools.chrome.enabled" = true;
            "devtools.debugger.remote-enabled" = true;

            # ── Dark Mode ────────────────────────────────────────────────────────────
            "ui.systemUsesDarkTheme" = 1; # Signal dark preference to websites & UI
            "browser.theme.content-theme" = 2; # Force internal pages (about:config, etc.) to dark
            "layout.css.prefers-color-scheme.content-override" = 2; # Web content respects dark preference
            "browser.tabs.allow_transparent_browser" = true; # Transparency for Zen blur/glass themes
            "devtools.theme" = "dark"; # DevTools dark theme

            # ── Reader Mode ──────────────────────────────────────────────────────────
            "reader.parse-on-load.force-enabled" = true; # Force Reader Mode on more sites
            "reader.font_type" = "sans-serif";
            "reader.font_size" = 5;

            # ── Privacy ──────────────────────────────────────────────────────────────
            "privacy.resistFingerprinting" = false; # Disabled: dark mode breaks with this on
            "media.peerconnection.enabled" = false; # Disable WebRTC IP leak
            "privacy.globalprivacycontrol.enabled" = true; # Send GPC signal to sites
            "dom.battery.enabled" = false; # Block Battery Status API (fingerprinting vector)
            "geo.enabled" = false; # Disable Geolocation API
            "permissions.default.geo" = 2; # Block geo permission prompts by default
            "network.dns.disablePrefetch" = true; # Don't prefetch DNS for unvisited links

            # Taken from
            # https://wiki.archlinux.org/title/Firefox/Privacy#Change_user_agent_and_platform
            "media.peerconnection.ice.default_address_only" = true;
            "network.http.sendRefererHeader" = 1;
            "network.http.referer.XOriginPolicy" = 1;
            "network.captive-portal-service.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "privacy.donottrackheader.enabled" = true;

            # ── Performance ──────────────────────────────────────────────────────────
            "general.smoothScroll.msdPhysics.enabled" = true; # Physics-based smooth scrolling
            "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
            "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
            "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
            "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 12;
            "nglayout.initialpaint.delay" = 0; # Snappier initial page paint
            "nglayout.initialpaint.delay_in_oopif" = 0;
            "content.notify.interval" = 100000; # 100 ms reflow interval (more responsive)
            "browser.tabs.unloadOnLowMemory" = true; # Unload background tabs under memory pressure
            "browser.cache.memory.capacity" = 524288; # 512 MB in-memory cache (in KB)
            "network.http.max-persistent-connections-per-server" = 10;
            "network.ssl_tokens_cache_capacity" = 10240; # Larger TLS session cache
            "gfx.webrender.all" = true; # Force WebRender compositor
            "gfx.webrender.precache-shaders" = true; # Pre-compile WebRender shaders at startup
            "media.hardware-video-decoding.force-enabled" = true; # Hardware video decoding

            # ── UI Enhancements ──────────────────────────────────────────────────────
            "browser.aboutConfig.showWarning" = false; # Skip about:config warning prompt
            "browser.uidensity" = 1; # 1 = compact — tighter toolbar
            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                "widget-overflow-fixed-list" = [ ];
                "unified-extensions-area" = [ ];
                "nav-bar" = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "urlbar-container"
                  "downloads-button"
                  "unified-extensions-button"
                ];
              };
              currentVersion = 20;
            };
            "browser.urlbar.suggest.calculator" = false; # Inline calculator in address bar
            "browser.urlbar.suggest.units" = false; # Unit conversion in address bar
            "browser.urlbar.trimURLs" = false; # Show full URL without trimming
            "browser.toolbars.bookmarks.visibility" = "never"; # Hide bookmarks toolbar
            "findbar.highlightAll" = true; # Highlight all find-bar matches
            "full-screen-api.transition-duration.enter" = "0 0"; # Instant fullscreen enter
            "full-screen-api.transition-duration.leave" = "0 0"; # Instant fullscreen leave
            "full-screen-api.warning.timeout" = 0; # No fullscreen warning overlay

            # ── Sidebar ──────────────────────────────────────────────────────────────
            "sidebar.old-sidebar.has-used" = true;
            "sidebar.verticalTabs" = true;
            "sidebar.position_start" = false; # Sidebar on the right
            "sidebar.revamp" = true;
            "sidebar.main.tools" = "syncedtabs,history,bookmarks";
            "sidebar.notification.badge.aichat" = false;

            # ── New Tab — disable all suggestions & sponsored content ────────────────
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
            "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.messaging-system.whatsNewPanel.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.system.snippets" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialTracking.enabled" = true;

            "network.prefetch-next" = false; # Don't prefetch linked pages
            "network.http.speculative-parallel-limit" = 0; # No speculative connections

            # disable hyperlink ping tracking
            "browser.send_pings" = false;

            # Disable Safe Browsing telemetry. It phones to Google.
            # Trade-off:  this disables phishing/malware warnings.
            # Skip if you'd rather keep them.
            "browser.safebrowsing.malware.enabled" = false;
            "browser.safebrowsing.phishing.enabled" = false;

            # Disable search suggestions. Keystrokes are sent to the search engines
            "browser.search.suggest.enabled" = false;
            "browser.urlbar.suggest.searches" = false;

            # Encrypted Client Hello: taken from ArchWiki on firefox
            "network.dns.echconfig.enabled" = true;
            "network.dns.http3_echconfig.enabled" = true;
            "network.trr.mode" = 2;

            # Suggested by claude
            "network.trr.uri" = "https://dns.quad9.net/dns-query";

            # Disable wasm, which is known to pass pre-compiled code with malware
            "javascript.options.wasm" = false;
            "javascript.options.wasm_baselinejit" = false;
            "javascript.options.wasm_ionjit" = false;

            # Disable webgl
            "webgl.disabled" = true;

            # Disable all suggestions:
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.recentsearches" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.quickactions" = false;

            # Disable data collection completely
            "datareporting.healthreport.uploadEnabled" = false;
            "browser.discovery.enabled" = false;
            "app.shield.optoutstudies.enabled" = false;
            "app.normandy.enabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.pioneer-new-studies-available" = false;
            "browser.ping-centre.telemetry" = false;
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;

            "browser.tabs.tabmanager.enabled" = false;

            "browser.startup.homepage" = "https://nixos.org";
            "browser.search.region" = "GB";
            "browser.search.isUS" = false;
            "distribution.searchplugins.defaultLocale" = "en-GB";
            "general.useragent.locale" = "en-GB";
            "browser.bookmarks.showMobileBookmarks" = true;
            "browser.newtabpage.pinned" = [
              {
                title = "NixOS";
                url = "https://nixos.org";
              }
            ];
          };
          containers = {
            Work = {
              id = 1;
              color = "blue";
              icon = "briefcase";
            };
          };
          containersForce = true;

          handlers = {
            force = true;
          };

          search = {
            force = true;
            default = "ddg";
          };
        };
      };

      xdg.mimeApps = {
        associations.added = {
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/chrome" = "firefox.desktop";
          "text/html" = "firefox.desktop";
          "application/x-extension-htm" = "firefox.desktop";
          "application/x-extension-html" = "firefox.desktop";
          "application/x-extension-shtml" = "firefox.desktop";
          "application/xhtml+xml" = "firefox.desktop";
          "application/x-extension-xhtml" = "firefox.desktop";
          "application/x-extension-xht" = "firefox.desktop";
        };
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
        };
      };
    };
}

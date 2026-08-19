{
  flake.homeModules.browsers =
    {
      pkgs,
      config,
      ...
    }:
    {
      xdg.configFile."firefox-startpage/startpage.html".source = ./startpage.html;
      programs = {
        firefox = {
          enable = true;
          # TODO: there's something wrong with the ln command in the derivation here
          # See todo.org
          # pkcs11Modules = [ pkgs.p11-kit ];

          globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
            {
              package = ublock-origin;
              settings = {
                private_browsing = true;
              };
            }
            {
              package = darkreader;
              settings = {
                private_browsing = true;
              };
            }
          ];

          policies = {
            DisableTelemetry = true;
            DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
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
              "devtools.theme" = "dark"; # DevTools dark theme

              # ── Reader Mode ──────────────────────────────────────────────────────────
              "reader.parse-on-load.force-enabled" = true; # Force Reader Mode on more sites
              "reader.font_type" = "sans-serif";
              "reader.font_size" = 5;

              # ── Privacy ──────────────────────────────────────────────────────────────
              "privacy.resistFingerprinting" = false; # Disabled: dark mode breaks with this on
              "media.peerconnection.enabled" = false; # Disable WebRTC IP leak, may perhaps stop WhatsApp from working
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

              # Custom startup page
              "browser.startup.homepage" = "file://${config.xdg.configHome}/firefox-startpage/startpage.html";
              "browser.newtab.url" = "file://${config.xdg.configHome}/firefox-startpage/startpage.html";
              "browser.startup.page" = 1;
              "browser.newtabpage.enabled" = false;

              "browser.search.region" = "GB";
              "browser.search.isUS" = false;
              "distribution.searchplugins.defaultLocale" = "en-GB";
              "general.useragent.locale" = "en-GB";
              "browser.bookmarks.showMobileBookmarks" = true;
            };
            bookmarks = {
              force = true;
              settings = [
                {
                  name = "WhatsApp";
                  keyword = "whatsapp";
                  url = "https://web.whatsapp.com/";
                }
                # Github Related
                {
                  name = "GitHub PRs";
                  keyword = "ghpr";
                  url = "https://github.com/pulls/inbox";
                }
                {
                  name = "GitHub Main Page";
                  keyword = "gh";
                  url = "https://github.com/";
                }
                {
                  name = "GitHub Notifications";
                  keyword = "ghn";
                  url = "https://github.com/notifications";
                }
                {
                  name = "GitHub My Dotfiles";
                  keyword = "ghdot";
                  url = "https://github.com/rachitvrma/dotfiles";
                }

                {
                  name = "Claude.Ai";
                  keyword = "claude";
                  url = "https://claude.ai/";
                }
                # For miniflux news, hardcoded
                {
                  name = "MiniFlux";
                  keyword = "news";
                  url = "http://localhost:8080/";
                }
                # See home-manager news
                {
                  name = "Home Manager News (Mstodon)";
                  keyword = "hmnews";
                  url = "https://techhub.social/@hmnews";
                }
                # Stylix main page
                {
                  name = "Stylix";
                  keyword = "stylix";
                  url = "https://nix-community.github.io/stylix/index.html";
                }
                # Nerd Fonts
                {
                  name = "Nerd Fonts";
                  keyword = "nerdfonts";
                  url = "https://www.nerdfonts.com/cheat-sheet";
                }
                # Read Manga
                {
                  name = "Comix";
                  keyword = "comix";
                  url = "https://comix.to/";
                }
                # Download Anime
                {
                  name = "Nyaa";
                  keyword = "nyaa";
                  url = "https://nyaa.si/";
                }
                # Chatgpt
                {
                  name = "ChatGPT";
                  keyword = "chatgpt";
                  url = "https://chatgpt.com/";
                }
                # Gemini
                {
                  name = "Gemini";
                  keyword = "gemini";
                  url = "https://gemini.google.com/app";
                }
                # X.com
                {
                  name = "X/Twitter";
                  keyword = "x";
                  url = "https://x.com/home";
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
              order = [
                "ddg"
                "google"
              ];
              engines = {
                # Nix Stack
                nix-packages = {
                  name = "Nix Packages";
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                        {
                          name = "channel";
                          value = "unstable";
                        }
                      ];
                    }
                  ];

                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@np" ];
                };
                nixos-options = {
                  name = "NixOS Options";
                  urls = [
                    {
                      template = "https://search.nixos.org/options";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@no" ];
                };
                nixos-wiki = {
                  name = "NixOS Wiki";
                  urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                  iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                  definedAliases = [ "@nw" ];
                };
                nixpkgs-pr-tracker = {
                  name = "Nixpkgs PR Tracker";
                  urls = [
                    {
                      template = "https://nixpk.gs/pr-tracker.html";
                      params = [
                        {
                          name = "pr";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  definedAliases = [ "@npt" ];
                };
                noogle = {
                  name = "Noogle";
                  urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
                  iconMapObj."16" = "https://noogle.dev/favicon.ico";
                  definedAliases = [ "@ng" ];
                };

                # YouTube Stack
                yt-music = {
                  name = "YouTube Music";
                  urls = [
                    {
                      template = "https://music.youtube.com/search";
                      params = [
                        {
                          name = "q";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  iconMapObj."16" = "https://music.youtube.com/favicon.ico";
                  definedAliases = [ "@ytm" ];
                };
                yt-videos = {
                  name = "YouTube";
                  urls = [
                    {
                      template = "https://www.youtube.com/results";
                      params = [
                        {
                          name = "search_query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  iconMapObj."16" = "https://www.youtube.com/favicon.ico";
                  definedAliases = [ "@yt" ];
                };

                bing.metaData.hidden = true;
                google.metaData.alias = "@g";

                # For RSS link lookup
                rsslookup = {
                  name = "RSS Lookup";
                  urls = [
                    {
                      template = "https://www.rsslookup.com/";
                      params = [
                        {
                          name = "url";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  definedAliases = [ "@rsslkup" ];
                };
              };
            };
          };
        };
      };

      stylix.targets.firefox.profileNames = [
        "krish"
      ];

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

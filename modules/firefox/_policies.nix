{ pkgs, ... }:
let
  extensions = import ./_extensions.nix;
in
{
  ExtensionSettings = {
    "*".installation_mode = "blocked";
  }
  // (builtins.listToAttrs extensions);

  # Use a proxy module rather than `nixpkgs.config.firefox.smartcardSupport = true`
  SecyrityDevices = {
    "PKCS#11 Proxy Module" = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
  };

  # -- Containers -------------------------------------------------
  Containers = {
    Default = [
      {
        name = "Work";
        icon = "briefcase";
        color = "blue";
      }
    ];
  };

  # ── Updates & Background Services ────────────────────────────────────────
  AppAutoUpdate = false;
  BackgroundAppUpdate = false;
  DisableSystemAddonUpdate = true; # Prevent silent system addon updates

  # ── Feature Disabling ────────────────────────────────────────────────────
  DisableBuiltinPDFViewer = true; # Use Zathura instead
  DisableFirefoxStudies = true;
  DisableFirefoxAccounts = true;
  DisableFirefoxScreenshots = true;
  DisableForgetButton = true;
  DisableMasterPasswordCreation = true;
  DisableProfileImport = true;
  DisableProfileRefresh = true;
  DisableSetDesktopBackground = true;
  DisablePocket = true;
  DisableTelemetry = true;
  DisableFormHistory = true;
  DisablePasswordReveal = true;
  DisableFeedbackCommands = true; # Remove Help → Submit Feedback

  # ── Access Restrictions ──────────────────────────────────────────────────
  BlockAboutConfig = false;
  BlockAboutProfiles = true;

  # ── Security Policies ────────────────────────────────────────────────────
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
  };
  SSLVersionMin = "tls1.2";
  HttpsOnlyMode = "force_enabled";

  # Go super hard private
  SanitizeOnShutdown = {
    Cache = true;
    Cookies = true;
    Downloads = true;
    FormData = true;
    History = true;
    Sessions = true;
    SiteSettings = true;
    OfflineApps = true;
  };

  Cookies = {
    Behavior = "reject-tracker-and-partition-foreign"; # Block trackers, partition 3rd-party
    Locked = false;

    # Allow some websites
    Allow = [
      "https://google.com"
      "https://github.com"
      "https://claude.ai"
      "https://chatgpt.com"
      "https://openai.com"
    ];
  };

  PopupBlocking = {
    Default = true;
    Locked = false;
  };

  UserMessaging = {
    WhatsNew = false;
    ExtensionRecommendations = false;
    FeatureRecommendations = false;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
  };

  # ── UI and Behaviour ─────────────────────────────────────────────────────
  DisplayMenuBar = "never";
  DontCheckDefaultBrowser = true;
  HardwareAcceleration = true;
  OfferToSaveLogins = false;
  DefaultDownloadDirectory = "/home/krish/Downloads";
  NoDefaultBookmarks = true;
  ShowHomeButton = false;

  # ── Search Engines ───────────────────────────────────────────────────────
  SearchEngines = {
    Default = "DuckDuckGo";
    Add = [
      # ── Nix / NixOS ─────────────────────────────────────────────────────
      {
        Name = "nixpkgs packages";
        URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
        IconURL = "https://wiki.nixos.org/favicon.ico";
        Alias = "@np";
      }
      {
        Name = "NixOS options";
        URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
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
      {
        Name = "home-manager options";
        URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
        IconURL = "https://wiki.nixos.org/favicon.ico";
        Alias = "@nhm";
      }
      {
        Name = "nix-wrapper-modules";
        URLTemplate = "https://birdeehub.github.io/nix-wrapper-modules/?search={searchTerms}";
        IconURL = "https://wiki.nixos.org/favicon.ico";
        Alias = "@nwm";
      }
      # ── Arch / Linux ─────────────────────────────────────────────────────
      {
        Name = "arch wiki";
        URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
        IconURL = "https://archlinux.org/favicon.ico";
        Alias = "@alwiki";
      }
      {
        Name = "Arch AUR";
        URLTemplate = "https://aur.archlinux.org/packages?K={searchTerms}";
        IconURL = "https://archlinux.org/favicon.ico";
        Alias = "@aur";
      }
      {
        Name = "man pages";
        URLTemplate = "https://man.archlinux.org/search?q={searchTerms}";
        IconURL = "https://archlinux.org/favicon.ico";
        Alias = "@man";
      }
      # ── GitHub ───────────────────────────────────────────────────────────
      {
        Name = "git repos";
        URLTemplate = "https://github.com/search?q={searchTerms}&type=repositories";
        IconURL = "https://github.com/favicon.ico";
        Alias = "@gitrepo";
      }
      {
        Name = "git code";
        URLTemplate = "https://github.com/search?q={searchTerms}&type=code";
        IconURL = "https://github.com/favicon.ico";
        Alias = "@gitcode";
      }
      # ── Developer References ─────────────────────────────────────────────
      {
        Name = "MDN Web Docs";
        URLTemplate = "https://developer.mozilla.org/en-US/search?q={searchTerms}";
        IconURL = "https://developer.mozilla.org/favicon.ico";
        Alias = "@mdn";
      }
      {
        Name = "crates.io";
        URLTemplate = "https://crates.io/search?q={searchTerms}";
        IconURL = "https://crates.io/favicon.ico";
        Alias = "@crates";
      }
      {
        Name = "docs.rs";
        URLTemplate = "https://docs.rs/releases/search?query={searchTerms}";
        IconURL = "https://docs.rs/favicon.ico";
        Alias = "@docsrs";
      }
      {
        Name = "PyPI";
        URLTemplate = "https://pypi.org/search/?q={searchTerms}";
        IconURL = "https://pypi.org/static/images/favicon.35549fe8.ico";
        Alias = "@pypi";
      }
      {
        Name = "Stack Overflow";
        URLTemplate = "https://stackoverflow.com/search?q={searchTerms}";
        IconURL = "https://stackoverflow.com/favicon.ico";
        Alias = "@so";
      }
      # ── Privacy-Respecting General Search ────────────────────────────────
      {
        Name = "Startpage";
        URLTemplate = "https://www.startpage.com/search?q={searchTerms}";
        IconURL = "https://www.startpage.com/favicon.ico";
        Alias = "@sp";
      }
      {
        Name = "Brave Search";
        URLTemplate = "https://search.brave.com/search?q={searchTerms}";
        IconURL = "https://search.brave.com/favicon.ico";
        Alias = "@brave";
      }
      {
        Name = "Kagi";
        URLTemplate = "https://kagi.com/search?q={searchTerms}";
        IconURL = "https://kagi.com/favicon.ico";
        Alias = "@kagi";
      }
      # ── Knowledge & Reference ─────────────────────────────────────────────
      {
        Name = "Wikipedia";
        URLTemplate = "https://en.wikipedia.org/w/index.php?search={searchTerms}";
        IconURL = "https://en.wikipedia.org/favicon.ico";
        Alias = "@wiki";
      }
      {
        Name = "Hacker News";
        URLTemplate = "https://hn.algolia.com/?q={searchTerms}";
        IconURL = "https://news.ycombinator.com/favicon.ico";
        Alias = "@hn";
      }

      # Firefox specific
      {
        Name = "Firefox Extensions";
        URLTemplate = "https://addons.mozilla.org/en-US/firefox/search/?q={searchTerms}";
        IconURL = "https://www.mozilla.org/favicon.ico";
        Alias = "@shortid";
      }
      {
        Name = "Firefox Extensions (Guid)";
        URLTemplate = "https://addons.mozilla.org/api/v5/addons/addon/{searchTerms}/";
        IconURL = "https://www.mozilla.org/favicon.ico";
        Alias = "@guid";
      }
    ];
  };
}

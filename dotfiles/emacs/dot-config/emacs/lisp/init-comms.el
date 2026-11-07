;;; init-comms.el --- IRC, Matrix and RSS -*- lexical-binding: t; -*-

;;; Code:

(defvar my/erc-soju-host "127.0.0.1"
  "Address of the local soju plaintext listener.")

(defvar my/erc-soju-port 6667
  "Port of the local soju plaintext listener.")

(defvar my/erc-soju-user "woodenAllen"
  "Soju account name.")

(defvar my/erc-soju-networks '("libera")
  "Network names configured in soju (see BouncerServ `network status').")

(defun my/erc-soju (network)
  "Connect to NETWORK through the local soju bouncer."
  (interactive
   (list (completing-read "Network: " my/erc-soju-networks nil t)))
  (erc :server my/erc-soju-host
       :port my/erc-soju-port
       :nick "woodenAllen"
       :user (format "%s/%s" my/erc-soju-user network)
       :password (auth-source-pass-get 'secret "irc/soju")
       :id (intern network)))

(defun my/erc-soju-libera ()
  "Connect to Libera.Chat through soju."
  (interactive)
  (my/erc-soju "libera"))

(use-package erc
  :ensure nil
  :bind (("C-c e l" . my/erc-soju-libera)
         ("C-c e c" . my/erc-soju))
  :custom
  ;; Retry forever: the bouncer is local and comes back within seconds.
  (erc-server-reconnect-attempts t)
  (erc-server-reconnect-timeout 10)
  ;; Soju keeps channels joined, so ERC must not manage them.
  (erc-autojoin-channels-alist nil)
  (erc-fill-function #'erc-fill-wrap)
  (erc-fill-column 100)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-track-shorten-start 8)
  :config
  (dolist (module '(nicks fill-wrap scrolltobottom))
    (add-to-list 'erc-modules module))
  (erc-update-modules))

(use-package ement
  :custom
  (ement-save-sessions t)
  (ement-save-sessions-file (expand-file-name "ement-sessions.el" user-emacs-directory))
  (ement-notify-notification-predicates
   '(ement-notify--event-mentions-session-user-p
     ement-notify--event-mentions-room-p)))

(use-package newsticker
  :bind ("C-c n" . newsticker-treeview)
  :custom
  ;; Fetch updates automatically in the background every hour (3600 seconds)
  (newsticker-retrieval-interval 3600)

  ;; Don't scroll headlines in the echo area (<= 0 disables the ticker)
  (newsticker-ticker-interval 0)

  ;; --- Cleanup & Cache Control ---
  ;; Delete items from Emacs storage once they are marked obsolete/old
  (newsticker-keep-obsolete-items nil)
  ;; Absolute fail-safe: force-delete unread articles after 14 days
  (newsticker-obsolete-item-max-age (* 14 24 60 60))

  ;; Define your feeds: '("Title" "URL")
  (newsticker-url-list
   '(("Noctalia" "https://noctalia.dev/rss.xml")
     ("Drew Devault's Blog" "https://drewdevault.com/blog/index.xml")
     ("Fedora Magazine" "https://fedoramagazine.org/feed/")
     ("FreeCodeCamp Blogs" "https://www.freecodecamp.org/news/tag/blog/rss/")
     ("FreeCodeCamp News" "https://www.freecodecamp.org/news/rss")
     ("FreeCodeCamp Programming Blogs" "https://www.freecodecamp.org/news/tag/programming-blogs/rss/")
     ("Ian Henry's Blog" "https://ianthehenry.com/feed.xml")
     ("Redhat Blog" "https://www.redhat.com/en/rss/blog")
     ("Simon Willison's Blog" "https://simonwillison.net/atom/everything/")
     ("Mini Nvim" "https://nvim-mini.org/blog/index.xml")
     ("Neovim News" "https://neovim.io/news.xml")
     ("Neovim Plugins" "https://dotfyle.com/neovim/plugins/rss.xml")
     ("Neovim Releases" "https://github.com/neovim/neovim/releases.atom")
     ("r/neovim" "https://www.reddit.com/r/neovim.rss")
     ("This Week In Neovim Dotfyle" "https://dotfyle.com/this-week-in-neovim/rss.xml")
     ("Krebs on Security" "https://krebsonsecurity.com/feed/")
     ("The Hacker News" "https://feeds.feedburner.com/TheHackersNews"))))

(provide 'init-comms)
;;; init-comms.el ends here

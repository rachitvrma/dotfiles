;;; init-comms.el --- Communication -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(defun my/erc-soju-libera ()
  (interactive)
  (erc :server "127.0.0.1"
       :port 6667
       :nick "woodenAllen"
       :user "woodenAllen/libera"
       :password (auth-source-pass-get 'secret "irc/soju")))

(use-package erc
  :bind (("C-c e l" . my/erc-soju-libera))
  :custom
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  (erc-autojoin-channels-alist
   '(("Libera.Chat" "#nixos" "#emacs"))))

(use-package rcirc
  :commands rcirc
  :config
  ;; Runs on first use of =M-x rcirc=, so pass/GPG is not asked at startup.
  (setq rcirc-server-alist
        `(("127.0.0.1"
           :port 6667
           :encryption plain
           :nick "woodenAllen"
           :user-name "woodenAllen/libera"
           :password ,(auth-source-pass-get 'secret "irc/soju")))))

(use-package ement
  :custom
  (ement-save-sessions t)
  (ement-save-sessions-file (expand-file-name "ement-sessions.el" user-emacs-directory)))

(use-package newsticker
  :bind ("C-c n" . newsticker-treeview)
  :custom
  ;; Fetch updates automatically in the background every hour (3600 seconds)
  (newsticker-retrieval-interval 3600)

  ;; Keep the mode-line clean by not showing the scrolling headline ticker
  (newsticker-display-interval nil)

  ;; --- Cleanup & Cache Control ---
  ;; Delete items from Emacs storage once they are marked obsolete/old
  (newsticker-keep-obsolete-items nil)
  ;; Absolute fail-safe: force-delete unread articles after 14 days
  (newsticker-obsolete-item-max-age (* 14 24 60 60))

  ;; Define your feeds: '("Title" "URL")
  (newsticker-url-list
   '(
     ("Noctalia" "https://noctalia.dev/rss.xml")
     ("Drew Devault's Blog" "https://drewdevault.com/blog/index.xml")
     ("Fedora Magazine" "https://fedoramagazine.org/feed/")
     ("FreeCodeCamp Blogs" "https://www.freecodecamp.org/news/tag/blog/rss/")
     ("FreeCodeCamp News" "https://www.freecodecamp.org/news/rss")
     ("FreeCodeCamp Programming Blogs" "https://www.freecodecamp.org/news/tag/programming-blogs/rss/")
     ("Home Manager News" "https://techhub.social/@hmnews.rss")
     ("Ian Henry's Blog" "https://ianthehenry.com/feed.xml")
     ("Redhat Blog" "https://www.redhat.com/en/rss/blog")
     ("Simon Willison's Blog" "https://simonwillison.net/atom/everything/")
     ("Mini Nvim" "https://nvim-mini.org/blog/index.xml")
     ("Neovim News" "https://neovim.io/news.xml")
     ("Neovim Plugins" "https://dotfyle.com/neovim/plugins/rss.xml")
     ("Neovim Releases" "https://github.com/neovim/neovim/releases.atom")
     ("r/neovim" "https://www.reddit.com/r/neovim.rss")
     ("This Week In Neovim Dotfyle" "https://dotfyle.com/this-week-in-neovim/rss.xml")
     ("NixOS discourse (announcements)" "https://discourse.nixos.org/latest.rss")
     ("NixOS Discourse (Announcements)" "https://discourse.nixos.org/c/announcements/8.rss")
     ("https://krebsonsecurity.com/feed/" "https://krebsonsecurity.com/feed/")
     ("The Hacker News" "https://feeds.feedburner.com/TheHackersNews")
     ("GNU Guix Blog" "https://guix.gnu.org/feeds/blog.atom")
     ))

  :config
  ;; Start the background retrieval process automatically
  (newsticker-start t))

(provide 'init-comms)
;;; init-comms.el ends here



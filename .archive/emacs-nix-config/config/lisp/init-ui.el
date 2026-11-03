;;; init-ui.el --- UI -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(use-package doom-themes
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-one") ; use "doom-colors" for less minimal icon theme
  (doom-themes-neotree-file-icons t) ; Use nerd-icons in neotree
  :config
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package neotree
  :bind ("C-c t" . neotree-toggle))

(use-package doom-modeline
  ;; Strictly prevent loading during daemon boot
  :defer t
  :init
  ;; Built-in modes don't need the GUI, safe to start immediately
  (display-time-mode 1)
  (display-battery-mode 1)

  (defun my/doom-modeline-setup-frame ()
    "Load and enable doom-modeline using real Wayland font metrics."
    (let ((frame (selected-frame)))
      (run-at-time "0.1 sec" nil
                   (lambda ()
                     (with-selected-frame frame
                       ;; Load the package here so its defaults initialize against the GUI
                       (require 'doom-modeline)
                       (doom-modeline-mode 1)
                       (doom-modeline-refresh-bars))))))

  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'my/doom-modeline-setup-frame)
    (require 'doom-modeline)
    (doom-modeline-mode 1)))

(use-package nerd-icons)

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; Adds icons to grep/rg/ripgrep-style result buffers (e.g. consult-grep).
(use-package nerd-icons-grep
  :after grep)

(use-package nerd-icons-xref
  :after xref
  :config
  (nerd-icons-xref-mode 1))

;; marginalia annotates minibuffer completions (file/buffer lists,
;; M-x, etc.); this adds an icon per candidate to those annotations.
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package dashboard
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-navigation-cycle t)
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-show-shortcuts t)
  ;; Removed: (initial-buffer-choice #'dashboard-open)
  :config
  (dashboard-setup-startup-hook)

  (if (daemonp)
    (add-hook 'server-after-make-frame-hook
              (lambda ()
                (let ((frame (selected-frame)))
                  ;; Wait 0.1s for Wayland to assign final geometry
                  (run-at-time "0.1 sec" nil
                               (lambda ()
                                 (with-selected-frame frame
                                   ;; This single call handles the rendering and centering
                                   (dashboard-open)))))))))

(use-package page-break-lines
  :init
  (page-break-lines-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

(use-package breadcrumb
  :config
  (breadcrumb-mode 1))

(use-package pulsar
  :bind
  (:map global-map
        ("C-x l" . pulsar-pulse-line)
        ("C-x L" . pulsar-highlight-permanently-dwim))
  :init
  (pulsar-global-mode 1)
  :hook
  ((next-error . pulsar-pulse-line)

   ;; Imenu integration
   (imenu-after-jump . pulsar-recenter-top)
   (imenu-after-jump . pulsar-reveal-entry)

   (minibuffer-setup . pulsar-pulse-line)

   ;; Consult
   (consult-after-jump . pulsar-recenter-top)
   (consult-after-jump . pulsar-reveal-entry)))

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("--" "---" "==" "===" "!=" "!==" "=!="
                                       "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
                                       "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
                                       "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
                                       "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
                                       "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
                                       "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
                                       "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
                                       "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
                                       "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
                                       "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
                                       ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
                                       "<:<" ";;;"))
  (global-ligature-mode t))

(use-package colorful-mode
  :custom
  (colorful-use-prefix t)
  ;; (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(use-package helpful
  :bind(
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key)
  ("C-h x" . helpful-command)
  ("C-h C-d" . helpful-at-point)
  ("C-h F" . helpful-function)))

(provide 'init-ui)
;;; init-ui.el ends here



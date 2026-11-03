;;; init-ui.el --- Theme, mode line, icons, dashboard and visual aids -*- lexical-binding: t; -*-

;;; Code:

(use-package neotree
  :custom
  (neo-theme (if (display-graphic-p) 'nerd-icons 'arrow))
  ;; Jump to the current file when the tree opens.
  (neo-smart-open t)
  :bind (("C-c t" . neotree-toggle)
         ([f8] . neotree-toggle)))

(use-package dashboard
  :custom
  (dashboard-banner-logo-title "GNU Emacsへようこそ、Krishさん!")
  (dashboard-startup-banner "~/.emacs.gif")
  (initial-buffer-choice (unless (daemonp) #'dashboard-open))
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-navigation-cycle t)

  ;; Nerd icons
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  ;; Show shortcuts
  (dashboard-show-shortcuts t)
  :config
  :config
  (defun my/dashboard-on-client-frame ()
    "Open the dashboard in a bare client frame and re-center it as the frame settles."
    (when (and (display-graphic-p)
               (string= (buffer-name) "*scratch*"))
      (dashboard-open)
      (let ((frame (selected-frame))
            watcher)
        (setq watcher
              (lambda (resized-frame)
                ;; Re-render only if the dashboard is still showing in this
                ;; frame, so Magit/commit windows are never hijacked.
                (when (eq resized-frame frame)
                  (when-let* ((win (get-buffer-window dashboard-buffer-name frame)))
                    (with-selected-window win
                      (dashboard-refresh-buffer))))))
        (add-hook 'window-size-change-functions watcher)
        ;; The WM may resize in more than one step (maximize, then
        ;; decorations), so keep re-centering for a short window of time
        ;; and then remove the watcher for good.
        (run-with-timer 2 nil
                        (lambda ()
                          (remove-hook 'window-size-change-functions watcher))))))

  (add-hook 'server-after-make-frame-hook #'my/dashboard-on-client-frame)
  (dashboard-setup-startup-hook))

(use-package page-break-lines
  :init
  (page-break-lines-mode))

(use-package doom-modeline
  ;; :custom registers values before the package loads, so the defcustom
  ;; defaults computed from (display-graphic-p) never win in a daemon.
  :custom
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-state-icon t)
  ;; A constant, so the default derived from the font at load time (5 in a
  ;; daemon, which shrinks the clock SVG) is never used. Adjust to taste.
  (doom-modeline-height 25)
  :hook (after-init . doom-modeline-mode))

(use-package nerd-icons)

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; Adds icons to grep/rg/ripgrep-style result buffers (e.g. consult-grep).
(use-package nerd-icons-grep
  :after grep
  :config
  (nerd-icons-grep-mode 1))

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
  :after (corfu nerd-icons)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; `tab-line-nerd-icons-global-mode' only adds icons to tabs that tab-line
;; already draws; it does not turn tab-line on. (The `tab-bar-show' setting
;; in init-core is the frame-level Tab Bar, a different feature.)
(use-package tab-line
  :ensure nil
  :config
  ;; Show the tab line only in windows that have more than one tab.
  ;; `tab-line-format' reserves a screen row whenever it is non-nil, even if
  ;; it renders empty, so the line is hidden by clearing the variable.
  (defvar my/tab-line--updating nil
    "Non-nil while `my/tab-line-update-visibility' runs (re-entrancy guard).")

  (defun my/tab-line-update-visibility (&rest _)
    "Show the tab line only in windows with more than one tab."
    (unless my/tab-line--updating
      (let ((my/tab-line--updating t))
        (walk-windows
         (lambda (win)
           (with-selected-window win
             (when tab-line-mode
               (let ((wanted (and (> (length (funcall tab-line-tabs-function)) 1)
                                  '(:eval (tab-line-format)))))
                 (unless (equal tab-line-format wanted)
                   (setq tab-line-format wanted))))))
         'nomini t))))

  (add-hook 'window-configuration-change-hook #'my/tab-line-update-visibility)
  (add-hook 'buffer-list-update-hook #'my/tab-line-update-visibility)
  (add-hook 'tab-line-mode-hook #'my/tab-line-update-visibility)

  (global-tab-line-mode 1))

(use-package tab-line-nerd-icons
  :after (nerd-icons tab-line)
  :config
  (tab-line-nerd-icons-global-mode 1))

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
                                       ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" ";;;"))
  (global-ligature-mode t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

(use-package breadcrumb
  :bind ("C-c b" . breadcrumb-jump)
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

;; Demap is a mimimap that helps navigate code.
(use-package demap
  :bind (("C-c m" . demap-toggle))
  :custom
  ;; Set the width of the minimap window (in columns)
  (demap-minimap-window-width 20))

(use-package helpful
  :bind(
        ("C-h f" . helpful-callable)
        ("C-h v" . helpful-variable)
        ("C-h k" . helpful-key)
        ("C-h x" . helpful-command)
        ("C-h C-d" . helpful-at-point)
        ("C-h F" . helpful-function)))

(use-package colorful-mode
  :custom
  (colorful-use-prefix t)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(defun my/apply-fonts (&rest _)
  "Set fixed- and variable-pitch families; re-run after every theme change."
  (set-face-attribute 'fixed-pitch nil :family "JetBrainsMono Nerd Font")
  (set-face-attribute 'variable-pitch nil :family "Iosevka Aile" :height 1.0))

(add-hook 'enable-theme-functions #'my/apply-fonts)
(my/apply-fonts)

(provide 'init-ui)
;;; init-ui.el ends here



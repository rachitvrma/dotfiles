;;; init-core.el --- Options, paths, TRAMP, environment, auth and package maintenance -*- lexical-binding: t; -*-

;;; Code:

(use-package no-littering
  :demand t
  :config
  ;; no-littering's own README recipe: auto-save files still need an
  ;; explicit redirect, everything else it handles on its own.
  ;;
  ;; Regex ".*" below:
  ;;   .   matches any single character (except a newline)
  ;;   *   repeats the item before it zero or more times
  ;;   so ".*" matches every file name, and every auto-save file
  ;;   is redirected into var/auto-save/
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(use-package emacs
  :init
  ;; "y or n" instead of typing out "yes"/"no" at every prompt.
  (setq use-short-answers t)
  (setq ring-bell-function 'ignore)

  ;; credit: Lukas Barth at https://www.lukas-barth.net/blog/emacs-wsl-copy-clipboard/
  (setopt select-active-regions nil)
  (setopt select-enable-clipboard 't)
  (setopt select-enable-primary nil)
  (setopt interprogram-cut-function #'gui-select-text)


  :hook
  ;; Display line numbers in programming modes only
  (prog-mode . display-line-numbers-mode)
  ((prog-mode org-mode) . hl-line-mode)

  :custom
  ;; Don't litter every directory with foo~ backup files and
  ;; #foo#/.#foo lock files.
  (make-backup-files nil)
  (create-lockfiles nil)
  ;; Load the newer of a .el/.elc pair instead of silently running
  ;; stale byte-compiled code.
  (load-prefer-newer t)
  ;; Keep the point away from the extreme edges of the frame in
  ;; term/tty scenarios; harmless elsewhere.
  (scroll-margin 2)
  (scroll-conservatively 101)

  ;; VERTICO INTEGRATION

  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)

  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))

  ;; Display relative line numbers
  (display-line-numbers-type 'relative)
  ;; Ensure the column doesn't aggresively jump in width as you scroll
  (display-line-numbers-width-start t)
  ;; Show the tab when there are more than one tab
  (tab-bar-show 1)

  :config
  ;; Redundant with the early-init default-frame-alist for the very
  ;; first frame, but this also covers any *later* frames (e.g. new
  ;; frames opened with emacsclient -c).
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (blink-cursor-mode -1)
  (column-number-mode 1)

  ;; Quality-of-life editing defaults.
  (save-place-mode 1)           ; reopen files at the last visited line
  (recentf-mode 1)              ; track recently opened files (consult-buffer uses this)
  (global-auto-revert-mode 1)   ; pick up on-disk changes automatically
  (delete-selection-mode 1)     ; typing replaces an active region
  (electric-pair-mode 1)        ; auto-close brackets/quotes (turned off locally where paredit is on)

  (global-visual-line-mode 1)   ; Enable softwrapping

  (display-time-mode 1)         ; Display the time in the modeline
  (display-battery-mode 1)      ; Display battery info

  (setq-default indent-tabs-mode nil
                tab-width 4
                fill-column 80)

  ;; Keep Custom's own noisy auto-generated `(custom-set-variables ...)`
  ;; block out of this file entirely.
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file 'noerror)))

(use-package elisp-mode
  :ensure nil
  :hook ((emacs-lisp-mode . flymake-mode)
         (emacs-lisp-mode . eldoc-mode)))   ; eldoc's on by default but explicit here is harmless

(use-package editorconfig
  :ensure nil
  :config
  (editorconfig-mode 1))

(use-package tramp
  :ensure nil
  :defer t)

(use-package exec-path-from-shell
  :config
  (when (or (memq window-system '(mac ns x pgtk))
            (daemonp))
    (exec-path-from-shell-copy-envs '("GNUPGHOME" "GPG_TTY" "SSH_AUTH_SOCK"))
    (exec-path-from-shell-initialize)))

(use-package direnv
  :config
  (if (executable-find "direnv")
      (direnv-mode)
    (message "direnv: executable not found, skipping direnv-mode")))

(use-package pinentry
  :custom
  (epg-pinentry-mode 'loopback)
  (epa-pinentry-mode 'loopback)
  :config
  (pinentry-start))

;; Enable pass integration so Emacs can read your ~/.password-store natively
(use-package auth-source-pass
  :ensure nil
  :demand t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)             ; Check for updates every 7 days
  (auto-package-update-prompt-before-update t) ; Ask for confirmation before updating
  (auto-package-update-hide-results t)         ; Hide the update results buffer
  (auto-package-update-delete-old-versions t)  ; Automatically delete old package versions
  :config
  ;; A daemon has no frame to show the confirmation prompt on at startup,
  ;; so only run the automatic check in a normal (non-daemon) session.
  ;; Note: this does not update :vc packages; use `package-vc-upgrade-all'.
  (unless (daemonp)
    (auto-package-update-maybe)))

(use-package password-store
  :defer t)

(provide 'init-core)
;;; init-core.el ends here

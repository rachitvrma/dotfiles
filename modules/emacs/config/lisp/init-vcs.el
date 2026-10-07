;;; init-vcs.el --- Version Control -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package majutsu
  :after magit
  :bind ("C-x j" . majutsu))

(use-package forge
  :after magit)

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         ;; Show git statuses in Dired buffers too
         (dired-mode . diff-hl-dired-mode)
         ;; Sync automatically with Magit/Majutsu actions
         (magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  ;; Calculate diffs live as you type, without needing to save the file
  (diff-hl-flydiff-mode 1)

  ;; By default, Emacs puts these signs in the graphical "Fringe".
  ;; Uncomment the line below if you prefer them shifted inward
  ;; to sit flush against the line numbers (closer to the Neovim look).
  ;; (diff-hl-margin-mode 1)
  )

(provide 'init-vcs)
;;; init-vcs.el ends here

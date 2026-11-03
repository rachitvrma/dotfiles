;;; init-vcs.el --- Magit, Majutsu and diff-hl -*- lexical-binding: t; -*-

;;; Code:

(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package majutsu
  :vc (:url "https://github.com/0WD0/majutsu")
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
  (diff-hl-flydiff-mode 1))

(provide 'init-vcs)
;;; init-vcs.el ends here



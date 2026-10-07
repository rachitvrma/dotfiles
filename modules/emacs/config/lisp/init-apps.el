;;; init-apps.el --- Applications -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(use-package emms
  :commands (emms emms-play-directory-tree)
  :init
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  :custom
  (emms-source-file-default-directory "~/Music/"))

(use-package reader
  :config
  (reader-global-dark-mode 1))

(use-package xdg-launcher)

(use-package aria2
  :defer t)

(provide 'init-apps)
;;; init-apps.el ends here

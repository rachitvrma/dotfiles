;;; init-apps.el --- Music, downloads, launcher and YouTube -*- lexical-binding: t; -*-

;;; Code:

(use-package emms
  :commands (emms emms-play-directory-tree emms-browse-by-album)
  :config
  (require 'emms-setup)
  (require 'emms-mpris)
  (emms-all)
  (emms-default-players)
  (emms-mpris-enable)
  :custom
  (emms-source-file-default-directory "~/Music/")
  (emms-browser-covers #'emms-browser-cache-thumbnail-async))

(use-package aria2
  :defer t)

(use-package yeetube
  :bind ("C-c y" . yeetube))

(use-package xdg-launcher
  :vc (:url "https://github.com/emacs-exwm/xdg-launcher"))

(provide 'init-apps)
;;; init-apps.el ends here

;;; init-web.el --- Web development helpers -*- lexical-binding: t; -*-

;;; Code:

(use-package emmet-mode
  :hook ((html-mode html-ts-mode css-ts-mode) . emmet-mode))

(use-package simple-httpd
  :defer t)

(use-package impatient-mode
  :commands impatient-mode)

(use-package jsdoc
  :defer t)

(use-package js
  :ensure nil
  :custom
  (js-indent-level 2))

(use-package css-mode
  :ensure nil
  :custom
  (css-indent-offset 2))

(use-package typescript-ts-mode
  :ensure nil
  :custom
  (typescript-ts-mode-indent-offset 2))

(provide 'init-web)
;;; init-web.el ends here

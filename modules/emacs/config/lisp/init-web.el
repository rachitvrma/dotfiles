;;; init-web.el --- Web Development -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(html-ts-mode . ("vscode-html-language-server" "--stdio"))))

(setq-default js-indent-level 2
              css-indent-offset 2
              typescript-ts-mode-indent-offset 2)

(use-package emmet-mode
  :hook ((html-ts-mode css-ts-mode tsx-ts-mode) . emmet-mode))

(use-package simple-httpd :commands httpd-start)
(use-package impatient-mode :commands impatient-mode)

(provide 'init-web)
;;; init-web.el ends here

;;; init-noctalia.el --- Noctalia theme -*- lexical-binding: t; -*-

;;; Code:

(let ((theme-file (expand-file-name
                   "~/.config/emacs/themes/noctalia-theme.el")))
  (when (file-exists-p theme-file)
    (add-to-list 'custom-theme-load-path
                 (file-name-directory theme-file))
    (load-theme 'noctalia t)))

(provide 'init-noctalia)
;;; init-noctalia.el ends here



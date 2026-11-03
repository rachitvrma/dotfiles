;;; init-org.el --- Org -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(use-package org
  :commands (org-capture org-agenda)
  :init
  (unless (file-directory-p (expand-file-name "~/org"))
    (make-directory (expand-file-name "~/org") t))
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture))

  :custom
  (org-directory "~/org")
  (org-agenda-files (list org-directory))
  (org-default-notes-file (concat org-directory "/notes.org"))
  (org-capture-templates
   '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
      "* TODO %?\n  %U\n  %i\n  %a"
      :empty-lines 1)
     ("j" "Journal" entry
      (file+olp+datetree "~/org/journal.org")
      "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
      :empty-lines 1)
     ("n" "Note" entry (file+headline org-default-notes-file "Notes")
      "* %?\n  %i\n  %a")))

  :hook
  (org-mode . org-indent-mode)
  (org-mode . variable-pitch-mode)

  :config
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("nix" . "src nix"))
  (add-to-list 'org-structure-template-alist '("bash" . "src bash"))
  )

(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

(use-package ispell
  :custom
  (ispell-program-name "aspell")
  (ispell-dictionary "en"))

;; Enable flyspell for markdown and org buffers
(use-package flyspell
  :hook (org-mode . flyspell-mode))

(provide 'init-org)
;;; init-org.el ends here



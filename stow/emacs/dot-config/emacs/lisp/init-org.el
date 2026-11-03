;;; init-org.el --- Org-mode and spell checking -*- lexical-binding: t; -*-

;;; Code:

(use-package org
  :ensure nil
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

  ;; Keep code, tables and metadata monospaced under `variable-pitch-mode'.
  (custom-set-faces
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch))))
   '(org-formula ((t (:inherit fixed-pitch))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-checkbox ((t (:inherit fixed-pitch))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-drawer ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-tag ((t (:inherit (shadow fixed-pitch))))))

  ;; Configure line-spacing
  (add-hook 'org-mode-hook (lambda () (setq-local line-spacing 0.15)))

  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("bash" . "src bash")))

(use-package ispell
  :ensure nil
  :custom
  (ispell-program-name "aspell")
  (ispell-dictionary "en"))

;; Enable flyspell for org buffers
(use-package flyspell
  :ensure nil
  :hook (org-mode . flyspell-mode))

(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

(provide 'init-org)
;;; init-org.el ends here



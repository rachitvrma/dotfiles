;;; init-editing.el --- Editing and Navigation -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(use-package avy
  :bind (("C-:" . avy-goto-char)
         ("M-g w" . avy-goto-word-1)
         ("M-g W" . avy-goto-subword-1))
  :custom
  (avy-all-windows t))

(use-package avy-zap
  :bind (("M-z" . avy-zap-to-char-dwim)
         ("M-Z" . avy-zap-up-to-char-dwim)))

(use-package avy-embark-collect
  :after embark)

(use-package ace-window
  :bind ("M-o" . ace-window)
  :custom
  ;; Mapped specifically to the Colemak-DH home row
  (aw-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o))
  (aw-scope 'frame))

;; which-key is built into Emacs 30
(use-package which-key
  :defer 0
  :config
  (which-key-mode 1))

(use-package undo-fu
  :bind

  (("C-z"   . undo-fu-only-undo)
   ("C-S-z" . undo-fu-only-redo)))

(use-package undo-fu-session
  :after undo-fu
  :custom
  (undo-fu-session-linear t)
  :config
  (undo-fu-session-global-mode))

(use-package vundo
  :bind ("C-x u" . vundo)
  :custom
  (vundo-glyph-alist vundo-unicode-symbols))

(use-package surround
  :bind-keymap ("C-c s" . surround-keymap))

(use-package zoxide
  :bind ("C-c z" . zoxide-travel))

(use-package hl-todo
  :config
  (global-hl-todo-mode))

;; Use consult-todo with hl-todo
(use-package consult-todo
  :demand t
  :config
  ;; Use narrows with consult-todo
  (defconst consult-todo--narrow
    '((?t . "TODO")
      (?f . "FIXME")
      (?b . "BUG")
      (?h . "HACK"))
    "Default mapping of narrow and keywords."))

(provide 'init-editing)
;;; init-editing.el ends here

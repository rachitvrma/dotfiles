;;; init-editing.el --- Navigation and editing helpers -*- lexical-binding: t; -*-

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

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

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
  :config
  ;; `:custom' is evaluated before vundo loads, when this variable is still void.
  (setq vundo-glyph-alist vundo-unicode-symbols))

(use-package zoxide
  :bind ("C-c z" . zoxide-travel))

(use-package ace-window
  :bind ("M-o" . ace-window)
  :custom
  ;; Mapped specifically to the Colemak-DH home row
  (aw-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o))
  (aw-scope 'frame))

;; which-key is built into Emacs 30
(use-package which-key
  :defer 0
  :ensure nil
  :config
  (which-key-mode 1))

(use-package surround
  :bind-keymap ("C-c s" . surround-keymap))

(use-package edit-indirect
  :defer t)

(use-package paredit
  :commands (enable-paredit-mode paredit-mode)
  ;; `:hook' appends "-hook" to each name.
  :hook ((emacs-lisp-mode
          eval-expression-minibuffer-setup
          ielm-mode
          lisp-mode
          lisp-interaction-mode) . enable-paredit-mode)
  :bind (:map paredit-mode-map
              ;; paredit's M-s (splice) would shadow the consult M-s prefix
              ("M-s" . nil)
              ("M-S" . paredit-splice-sexp))
  :preface
  ;; "Electric RETURN" from the wiki: pressing RET just before a closing
  ;; character opens an extra line, which paredit-close-round regathers.
  ;;
  ;; Regex "[]})\"]":
  ;;   [ ... ]  a bracket expression: match exactly ONE character from the set
  ;;   a ] placed first inside the brackets is taken literally, so the set holds ]
  ;;   }  and  )  are plain literal characters inside brackets
  ;;   \"  is the Elisp string escape for a double quote (not regex syntax)
  ;; `looking-at' only tests the text starting exactly at point, so this
  ;; fires only when the next character is ], }, ) or a double quote.
  (defvar electrify-return-match "[]})\"]"
    "If this regexp matches the text after point, RET does an electric return.")

  (defun electrify-return-if-match (arg)
    "If text after point matches `electrify-return-match', open and indent
an empty line between point and that text, then insert a newline."
    (interactive "P")
    (let ((case-fold-search nil))
      (when (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
      (newline arg)
      (indent-according-to-mode)))
  :init
  ;; The wiki says local-set-key in a mode hook is better than a global
  ;; binding. The minibuffer is left out on purpose, so its own RET
  ;; handling keeps working.
  (dolist (hook '(emacs-lisp-mode-hook
                  lisp-mode-hook
                  lisp-interaction-mode-hook))
    (add-hook hook (lambda ()
                     (local-set-key (kbd "RET") #'electrify-return-if-match))))
  :config
  ;; Make ElDoc refresh the echo area after paredit commands.
  ;; The argument is a plain prefix string, not a regex.
  (require 'eldoc)
  (eldoc-add-command-completions "paredit-")
  ;; Avoid double-inserted closers, since electric-pair-mode is global.
  (add-hook 'paredit-mode-hook (lambda () (electric-pair-local-mode -1))))

(provide 'init-editing)
;;; init-editing.el ends here

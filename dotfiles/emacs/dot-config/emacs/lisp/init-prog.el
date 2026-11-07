;;; init-prog.el --- LSP, formatting and tree-sitter -*- lexical-binding: t; -*-

;;; Code:

(use-package eglot
  :hook ((bash-ts-mode
          c-ts-mode
          c++-ts-mode
          python-ts-mode
          html-mode
          html-ts-mode
          css-ts-mode
          js-ts-mode
          typescript-ts-mode
          tsx-ts-mode
          json-mode
          yaml-ts-mode
          tex-mode
          LaTeX-mode
          toml-ts-mode
          systemd-mode
          nix-mode
          fish-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l r" . eglot-rename)
              ("C-c l d" . eldoc)
              ("C-c l R" . eglot-reconnect)
              ("C-c l q" . eglot-shutdown)
              ("C-c l h" . eglot-inlay-hints-mode))
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  (eglot-watch-files-outside-project-root nil) ; stop servers from watching irrelevant directories
  :config
  (add-to-list 'eglot-server-programs
               '(toml-ts-mode . ("tombi" "lsp")))
  (add-to-list 'eglot-server-programs
               '(nix-mode . ("nixd" "--semantic-tokens=true" "--inlay-hints=false")))
      (add-to-list 'eglot-server-programs
               '((html-mode html-ts-mode) . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(systemd-mode . ("systemd-lsp")))
  (add-to-list 'eglot-server-programs
               '(fish-mode . ("fish-lsp" "start"))))

(use-package apheleia
  :init
  (apheleia-global-mode 1)
  :config
  ;; Universal fallback: wire web and config languages to dprint
  (dolist (mode '(html-mode html-ts-mode css-ts-mode js-ts-mode
                            typescript-ts-mode tsx-ts-mode
                            json-mode toml-ts-mode yaml-ts-mode markdown-mode))
    (setf (alist-get mode apheleia-mode-alist) 'dprint)))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package mason
  :config
  (mason-setup))

(use-package tempel
  :bind (("M-+" . tempel-complete)
         ("M-*" . tempel-insert))
  :preface
  (defun my/tempel-setup-capf ()
    "Add Tempel to the completion-at-point sources of this buffer."
    (setq-local completion-at-point-functions
                (cons #'tempel-complete completion-at-point-functions)))
  :hook (prog-mode . my/tempel-setup-capf))

(use-package eglot-tempel
  :after (eglot tempel)
  :config
  (eglot-tempel-mode 1))

(use-package tempel-collection
  :after tempel)

(use-package systemd
  :defer t)

(use-package fish-mode)

(use-package json-mode
  :mode "\\.json\\'")

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package geiser
  :defer t
  :custom
  (geiser-default-implementation 'guile)
  (geiser-active-implementations '(guile))
  ;; Don't auto-start a REPL when opening a file; start it yourself
  (geiser-mode-start-repl-p nil))

(use-package geiser-guile
  :after geiser
  :config
  ;; Point Geiser at your local Guix checkout and personal channel if present
  (when (file-directory-p "~/src/guix")
    (add-to-list 'geiser-guile-load-path "~/src/guix"))
  (when (file-directory-p "~/src/my-guix-channel")
    (add-to-list 'geiser-guile-load-path "~/src/my-guix-channel")))

;; `guix-devel' ships inside the `guix' MELPA package, so `:ensure guix'
;; tells package.el to install `guix' instead of looking for `guix-devel'.
(use-package guix-devel
  :ensure guix
  :hook (scheme-mode . guix-devel-mode))

(use-package sly
  :defer t
  :custom
  (inferior-lisp-program "sbcl")
  :config
  (setq sly-lisp-implementations
        '((sbcl ("sbcl"))
          (clisp ("clisp")))))

(use-package pyvenv
  :defer t)

(provide 'init-prog)
;;; init-prog.el ends here

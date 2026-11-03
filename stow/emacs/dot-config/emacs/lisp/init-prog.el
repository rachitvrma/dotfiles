;;; init-prog.el --- LSP, formatting and tree-sitter -*- lexical-binding: t; -*-

;;; Code:

(use-package eglot
  :hook ((bash-ts-mode
          just-mode
          c-ts-mode
          c++-ts-mode
          python-ts-mode
          html-mode
          html-ts-mode
          css-ts-mode
          js-ts-mode
          typescript-ts-mode
          tsx-ts-mode
          json-ts-mode
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
               '(just-mode . ("just-lsp")))
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
                            json-ts-mode toml-ts-mode yaml-ts-mode markdown-mode))
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

(use-package just-mode)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package pyvenv
  :defer t)

(provide 'init-prog)
;;; init-prog.el ends here

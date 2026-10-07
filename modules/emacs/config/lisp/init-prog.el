;;; init-prog.el --- Programming -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

;; Tree-sitter grammars
(use-package treesit
  :config
  (setq major-mode-remap-alist
        '((sh-mode         . bash-ts-mode)
          (c-mode          . c-ts-mode)
          (c++-mode        . c++-ts-mode)
          (python-mode     . python-ts-mode)
          (css-mode        . css-ts-mode)
          (html-mode       . html-ts-mode)
          (javascript-mode . js-ts-mode)
          (js-mode         . js-ts-mode)
          (json-mode       . json-ts-mode)
          (yaml-mode       . yaml-ts-mode)
          (toml-mode       . toml-ts-mode))))

;; nix-ts-mode isn't remapping a built-in mode the way bash-ts-mode
;; remaps sh-mode -- there's no built-in "nix-mode" in Emacs at all --
;; so it's registered directly against the file extension instead.
(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package json-ts-mode
  :mode "\\.json\\'")

(use-package eglot
  :hook ((nix-ts-mode
          bash-ts-mode
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
          scheme-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l r" . eglot-rename)
              ("C-c l d" . eldoc)
              ("C-c l R" . eglot-reconnect)
              ("C-c l q" . eglot-shutdown)
              ("C-c l h" . eglot-inlay-hints-mode)
              )
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  (eglot-watch-files-outside-project-root nil) ; stop pyright from watching the Nix store
  :config
  (add-to-list 'eglot-server-programs
               '(nix-ts-mode . ("nixd" "--semantic-tokens=true" "--inlay-hints=false")))
  (add-to-list 'eglot-server-programs
               '(toml-ts-mode . ("tombi" "lsp")))
  (add-to-list 'eglot-server-programs
               '(systemd-mode . ("systemd-lsp"))))

(use-package apheleia
  :init
  (apheleia-global-mode 1)
  :config
  (setf (alist-get 'nix-mode apheleia-mode-alist) 'nixfmt)
  ;; Universal fallback: Wire web and config languages to Dprint
  (dolist (mode '(html-mode html-ts-mode css-ts-mode js-ts-mode
                            typescript-ts-mode tsx-ts-mode
                            json-ts-mode toml-ts-mode yaml-ts-mode markdown-mode))
    (setf (alist-get mode apheleia-mode-alist) 'dprint)))

(use-package systemd
  :defer t)

(provide 'init-prog)
;;; init-prog.el ends here

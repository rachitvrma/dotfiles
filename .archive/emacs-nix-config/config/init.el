;;; init.el --- Loader for the tangled modules -*- lexical-binding: t; -*-

;;; Commentary:

;; Generated from Config.org. Edit that file, not this one.

;;; Code:

;; Does what it says
(setq use-package-verbose t
      package-vc-allow-build-commands nil ;; Use nix to package stuff
      debug-on-error t)

(require 'use-package)

;; lisp/ is symlinked into ~/.config/emacs by module.nix.
(add-to-list 'load-path (locate-user-emacs-file "lisp"))

(defconst my/modules
  '(
  init-core
  init-ui
  init-completion
  init-editing
  init-files
  init-vcs
  init-prog
  init-web
  init-latex
  init-org
  init-comms
  init-apps
    )
  "Modules to load, in order. Each one is lisp/<name>.el.")

(dolist (module my/modules)
  (condition-case err
      (require module)
    (error
     (display-warning 'init
                      (format "%s failed to load: %s"
                              module (error-message-string err))
                      :error))))

(provide 'init)
;;; init.el ends here



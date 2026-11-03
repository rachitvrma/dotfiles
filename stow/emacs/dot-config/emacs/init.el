;;; init.el --- Config for my Emacs -*- lexical-binding: t; -*-

;;; Commentary:

;; This is my personal Emacs configuration.

;;; Code:

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)
;; Don't block a daemon on the network at startup; `use-package' with
;; :ensure refreshes the archives itself if a package can't be found.
(unless (or package-archive-contents (daemonp))
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(require 'package-vc)
(setq use-package-verbose t
      package-vc-allow-build-commands t)

;; package-vc-install refuses to touch an existing checkout directory,
;; which turns any interrupted :vc install (daemon killed mid-clone,
;; a prior crash-loop, etc.) into a permanent startup failure on every
;; subsequent launch. Wipe a *broken* checkout before it retries; a
;; healthy one (git can resolve HEAD) is left alone so upgrades and
;; rebuilds don't lose it.
;; advice-add (unlike add-function) is documented to handle advising
;; a not-yet-loaded autoloaded function correctly, so this doesn't
;; need package-vc/vc-git required up front -- the advice attaches
;; now and only actually runs the first time a :vc install happens.
(advice-add 'package-vc--unpack :before
            (lambda (pkg-desc &rest _)
              (let ((dir (package-desc-dir pkg-desc)))
                (when (and dir (file-directory-p dir)
                           (not (zerop (call-process
                                        "git" nil nil nil "-C" dir
                                        "rev-parse" "--verify" "HEAD"))))
                  (delete-directory dir t)))))

;; Shallow-clone :vc packages (full history is never needed for an
;; installed dependency). Scoped to package-user-dir so this doesn't
;; affect unrelated git-clone calls (e.g. from Magit) elsewhere.
(advice-add 'vc-git-clone :around
            (lambda (orig remote directory rev)
              (if (not (file-in-directory-p directory package-user-dir))
                  (funcall orig remote directory rev)
                (if (null rev)
                    (vc-git--out-ok "clone" "--depth" "1" remote directory)
                  (or (ignore-errors
                        (vc-git--out-ok "clone" "--depth" "1" "--branch" rev
                                        "--single-branch" remote directory))
                      (progn
                        (vc-git--out-ok "clone" remote directory)
                        (let ((default-directory directory))
                          (vc-git--out-ok "checkout" rev)))))
                directory)))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defvar my/modules
  '(init-core init-ui init-completion init-editing init-files init-vcs
              init-prog init-web init-latex init-org init-comms init-apps init-noctalia)
  "Configuration modules, loaded in this order from the lisp/ directory.")

(dolist (module my/modules)
  (condition-case err
      (require module)
    (error (message "Failed to load %s: %s" module (error-message-string err)))))

(provide 'init)
;;; init.el ends here



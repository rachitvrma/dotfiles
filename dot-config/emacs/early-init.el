;;; early-init.el --- -*- lexical-binding: t; -*-

;; Open Emacs in full screen mode
(push '(fullscreen . maximized) default-frame-alist)

(add-to-list 'default-frame-alist '(alpha-background . 95))

;; Give startup a large GC budget so package/config loading doesn't
;; stall on collections, then put a sane (but still generous) limit
;; back once the frame is up.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024) ; 32MB
                  gc-cons-percentage 0.1)))

(setq use-package-always-ensure t)
(setq use-package-compute-statistics nil)

(setq default-frame-alist
      (append '((menu-bar-lines . 0)
                (tool-bar-lines . 0)
                (vertical-scroll-bars . nil)
                (horizontal-scroll-bars . nil)
                (ns-transparent-titlebar . t)
                (font . "JetBrainsMono Nerd Font-13"))
              default-frame-alist))

;; The frame resizes itself in pixel steps as fonts/lines change,
;; instead of Emacs eagerly re-fitting it to a character grid.
(setq frame-inhibit-implied-resize t)

;; Skip the "Welcome to GNU Emacs" splash and any related redisplay
;; work; the dashboard package (configured in init.el) replaces it.
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name)

(setq native-comp-async-report-warnings-errors 'silent)
(setq warning-minimum-level :error)

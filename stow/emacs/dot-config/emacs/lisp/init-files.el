;;; init-files.el --- Dired, Ibuffer and project.el -*- lexical-binding: t; -*-

;;; Code:

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom
  (dired-listing-switches "-algho --group-directories-first")
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-dwim-target t)
  (delete-by-moving-to-trash t)
  :hook (dired-mode . dired-hide-details-mode)
  :bind (:map dired-mode-map
              (";" . dired-up-directory)
              ("." . dired-omit-mode)))

(use-package dired-x
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :custom
  ;; Regex "^\\.": ^ anchors to the start of the file name and \\. is a
  ;; literal dot (the Elisp string "\\." becomes the regex \.), so every
  ;; name beginning with a dot (dotfiles) is hidden.
  (dired-omit-files "^\\."))

(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-expert t)
  (ibuffer-default-sorting-mode 'filename/process)
  (ibuffer-formats
   '((mark modified read-only locked " "
           (name 30 30 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename)))

  :hook
  (ibuffer-mode . (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

  :config
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("Org Agenda" (mode . org-agenda-mode))
           ("Org"        (mode . org-mode))
           ("News"       (or (name . "^\\*newsticker")
                             (predicate . (derived-mode-p 'newsticker-mode
                                                          'newsticker-treeview-mode))))
           ("Web"        (or (mode . eww-mode)
                             (mode . xwidget-webkit-mode)))
           ("EMMS"       (predicate . (derived-mode-p 'emms-playlist-mode
                                                      'emms-browser-mode
                                                      'emms-stream-mode)))
           ("VCS"        (or (predicate . (derived-mode-p 'magit-mode))
                             (mode . vc-dir-mode)))
           ("Dired"      (mode . dired-mode))
           ("IRC"        (or (mode . erc-mode)
                             (mode . rcirc-mode)))
           ("Ement"      (or (predicate . (derived-mode-p 'ement-room-mode
                                                          'ement-room-list-mode
                                                          'ement-directory-mode))
                             (name . "^\\*Ement")))
           ("Files"      (predicate . (and (buffer-file-name)
                                           (not (derived-mode-p 'dired-mode)))))
           ("Special"    (name . "^\\*"))))))

(use-package project
  :ensure nil
  :bind (:map project-prefix-map
              ("m" . magit-project-status)
              ("r" . consult-ripgrep))
  :custom
  ;; Define the dispatch menu that appears when switching projects (C-x p p)
  (project-switch-commands
   '((project-find-file "Find file" ?f)
     (project-dired "Dired" ?d)
     (magit-project-status "Magit status" ?m)
     (consult-ripgrep "Search (ripgrep)" ?r)
     (project-find-dir "Find directory" ?D)
     (project-kill-buffers "Kill project buffers" ?k))))

(provide 'init-files)
;;; init-files.el ends here

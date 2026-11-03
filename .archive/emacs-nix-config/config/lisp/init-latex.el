;;; init-latex.el --- LaTeX -*- lexical-binding: t; -*-

;;; Commentary:

;; Tangled from Config.org. Edit that file, not this one.

;;; Code:

(use-package tex
  :defer t
  :hook (LaTeX-mode . turn-on-reftex)
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (TeX-command-default "LatexMk")
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  (TeX-view-program-selection '((output-pdf "Zathura")))
  (TeX-view-program-list
   '(("Zathura" "zathura --synctex-forward %n:0:%b %o" "zathura"))))


(use-package cdlatex
  :after tex
  :hook (LaTeX-mode . turn-on-cdlatex))

(provide 'init-latex)
;;; init-latex.el ends here



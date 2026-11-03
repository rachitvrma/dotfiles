;;; init-latex.el --- LaTeX (AUCTeX) setup -*- lexical-binding: t; -*-

;;; Code:

(use-package tex
  :ensure auctex
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



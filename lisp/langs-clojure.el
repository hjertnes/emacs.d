;; Clojure support
(use-package 
  clojure-mode
  :ensure t)
;; Clojure Repl integration and much more
(use-package 
  cider
  :ensure t 
  :config (progn (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion) 
		 (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion) 
		 (add-hook 'after-save-hook 
			   (lambda() 
			     (when (eq major-mode 'clojure-mode) 
			       (cider-load-buffer))))))
(provide 'langs-clojure)

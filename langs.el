(use-package 
  lsp-python 
  :ensure t 
  :defer 2 
  :init (add-hook 'python-mode-hook #'lsp-python-enable))
(use-package 
  docker 
  :ensure t 
  :defer 2 
  :bind ("C-c d" . docker))
(use-package 
  markdown-mode 
  :ensure t 
  :defer 2 
  :commands (markdown-mode gfm-mode) 
  :mode (("README\\.md\\'" . gfm-mode) 
	 ("\\.txt\\'" . markdown-mode) 
	 ("\\.md\\'" . markdown-mode) 
	 ("\\.markdown\\'" . markdown-mode)) 
  :init (setq markdown-command "multimarkdown"))
(use-package 
  taskpaper-mode 
  :defer 2 
  :ensure t)
(use-package 
  cider 
  :ensure t 
  :defer 2 
  :config (add-hook 'after-save-hook 
		    (lambda() 
		      (when (eq major-mode 'clojure-mode) 
			(cider-load-buffer)))))
(use-package 
  elisp-format 
  :defer 2 
  :ensure t)

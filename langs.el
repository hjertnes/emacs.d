(use-package 
  lsp-python 
  :ensure t 
  :init (add-hook 'python-mode-hook #'lsp-python-enable))
(use-package 
  markdown-mode 
  :ensure t 
  :commands (markdown-mode gfm-mode) 
  :mode (("README\\.md\\'" . gfm-mode) 
	 ("\\.txt\\'" . markdown-mode) 
	 ("\\.md\\'" . markdown-mode) 
	 ("\\.markdown\\'" . markdown-mode)) 
  :init (setq markdown-command "multimarkdown"))
(use-package 
  taskpaper-mode 
  :ensure t)
(use-package 
  clojure-mode 
  :ensure t)
(use-package 
  cider 
  :ensure t 
  :config (add-hook 'after-save-hook 
		    (lambda() 
		      (when (eq major-mode 'clojure-mode) 
			(cider-load-buffer)))))
(use-package 
  elisp-format 
  :ensure t)

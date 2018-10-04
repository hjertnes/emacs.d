(use-package 
  lsp-python 
  :ensure t 
  :init (add-hook 'python-mode-hook #'lsp-python-enable))
(use-package 
  company-tern 
  :ensure t 
  :after (company) 
  :config (add-to-list 'company-backends 'company-tern))
(use-package 
  web-mode 
  :ensure t 
  :mode (".html?") 
  :config (setq web-mode-markup-indent-offset 2 web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2 web-mode-enable-auto-closing t
		web-mode-enable-auto-opening t web-mode-enable-auto-pairing t
		web-mode-enable-auto-indentation t))
(use-package 
  js2-mode 
  :ensure t  
  :after (company-tern company) 
  :config (add-hook 'js2-mode-hook 
		    (lambda () 
		      (tern-mode)
		      (company-mode))))
(use-package 
  rjsx-mode 
  :ensure t  
  :after (company-tern company) 
  :config (add-hook 'rjsx-mode-hook 
		    (lambda () 
		      (tern-mode)
		      (company-mode))))
(use-package 
  tide 
  :ensure t 
  :after (typescript-mode company flycheck) 
  :hook ((typescript-mode . tide-setup) 
	 (typescript-mode . tide-hl-identifier-mode) 
	 (before-save . tide-format-before-save)))
(use-package 
  docker 
  :ensure t 
  :bind ("C-c d" . docker))
(use-package 
  omnisharp 
  :ensure t 
  :after (company flycheck) 
  :config (add-to-list 'company-backends #'company-omnisharp) 
  (add-hook 'csharp-mode-hook 
	    (lambda()
	      (omnisharp-mode)
	      (company-mode)
	      (flycheck-mode)
	      (setq indent-tabs-mode nil)
	      (setq c-syntactic-indentation t)
	      (c-set-style "ellemtel")
	      (setq c-basic-offset 4)
	      (setq truncate-lines t)
	      (setq tab-width 4)
	      (setq evil-shift-width )
	      (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
	      (local-set-key (kbd "C-c C-c") 'recompile))
	    t))
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
  writeroom-mode  
  :ensure t)
(use-package 
  taskpaper-mode 
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

(use-package 
	indent-guide 
  :ensure t 
  :config (indent-guide-global-mode))
(use-package 
	which-key 
  :ensure t 
  :config (which-key-mode))
(use-package 
	rainbow-delimiters 
  :ensure t 
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package 
	rainbow-identifiers 
  :ensure t 
  :config (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))

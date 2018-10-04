(use-package 
  indent-guide  
  :ensure t 
  :config (indent-guide-global-mode))
(use-package 
  which-key  
  :ensure t 
  :config (which-key-mode))
(use-package 
  hlinum  
  :ensure t 
  :init (setq linum-highlight-in-all-buffersp t) 
  :config (hlinum-activate)
  (global-linum-mode t))
(use-package 
  rainbow-delimiters  
  :ensure t 
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package 
  rainbow-identifiers  
  :ensure t 
  :config (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))
(use-package 
  smart-mode-line 
  :ensure t 
  :init (setq sml/theme 'dark sml/no-confirm-load-theme t) 
  :config (sml/setup))
(use-package 
  all-the-icons 
  :ensure t)
(use-package 
  page-break-lines 
  :ensure t 
  :config (set-fontset-font "fontset-default" (cons page-break-lines-char page-break-lines-char) 
			    (face-attribute 'default 
					    :family)))
(use-package 
  nimbus-theme 
  :ensure t 
  :config (load-theme 'nimbus  t))

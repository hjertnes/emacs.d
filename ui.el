;; Show guides for different ident levels.
(use-package 
  indent-guide 
  :ensure t 
  :config (indent-guide-global-mode))
;; Show hints when you have typed parts of a keybinding
(use-package 
  which-key 
  :ensure t 
  :config (which-key-mode))
;; Use different colors of delimiters and identifiers
(use-package 
  rainbow-delimiters 
  :ensure t 
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package 
  rainbow-identifiers 
  :ensure t 
  :config (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))
;; Use the dracula theme
(use-package 
  dracula-theme 
  :ensure t 
  :config (load-theme 'dracula t))

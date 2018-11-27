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
;; Dark theme for smart mode line
(use-package 
  smart-mode-line-atom-one-dark-theme 
  :ensure t)
;; Use the dracule theme
(if (display-graphic-p) ;only when used in GUI mode
    (use-package 
      dracula-theme 
      :ensure t
      :config (load-theme 'dracula t))
  (load-theme 'misterioso))
;; SML is a better looking mode line for emacs
(use-package 
  smart-mode-line 
  :ensure t
  :init (if (display-graphic-p) (setq sml/no-confirm-load-theme t sml/theme 'atom-one-dark)(setq sml/no-confirm-load-theme t sml/theme 'dark))
  :config (sml/setup))
(provide 'ui)

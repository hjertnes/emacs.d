;; org-mode
(use-package 
  org 
  :ensure t 
  :pin org)
(use-package 
  org-bullets 
  :ensure t 
  :config (add-hook 'org-mode-hook 'org-bullets-mode))
(use-package 
  org-beautify-theme 
  :ensure t)
(provide 'langs-org)


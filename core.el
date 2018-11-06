(use-package 
  smex 
  :ensure t 
  :defer 2 
  :config (smex-initialize))
(use-package 
  undo-tree 
  :defer 2 
  :ensure t 
  :config (global-undo-tree-mode))
(use-package 
  exec-path-from-shell 
  :defer 2 
  :ensure t 
  :config (exec-path-from-shell-initialize))
(use-package 
  smartparens-config 
  :defer 2 
  :config (show-smartparens-global-mode t) 
  (smartparens-global-mode t))
(use-package 
  projectile 
  :ensure t 
  :defer 2 
  :config (projectile-mode) 
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))
(use-package 
  counsel 
  :ensure t 
  :config (ivy-mode 1) 
  (global-set-key (kbd "C-s") 'swiper) 
  (global-set-key (kbd "M-x") 'counsel-M-x) 
  (global-set-key (kbd "C-x C-f") 'counsel-find-file) 
  (global-set-key (kbd "<f1> f") 'counsel-describe-function) 
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable) 
  (global-set-key (kbd "<f1> l") 'counsel-find-library) 
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol) 
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char) 
  :init (setq  ivy-initial-inputs-alist nil ivy-use-virtual-buffers t ivy-count-format "(%d/d)"))
(use-package 
  counsel-projectile 
  :defer 2 
  :ensure t 
  :config (counsel-projectile-mode +1))
(use-package 
  flycheck 
  :defer 2 
  :ensure t 
  :config(global-flycheck-mode))
(use-package 
  company 
  :defer 2 
  :ensure t 
  :config (company-mode +1) 
  (global-company-mode +1))
(use-package 
  lsp-mode 
  :defer 2 
  :ensure t)
(use-package 
  ace-jump-mode 
  :ensure t)

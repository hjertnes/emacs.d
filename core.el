


(use-package 
  undo-tree 
  :ensure t 
  :config (global-undo-tree-mode))
(use-package 
  exec-path-from-shell 
  :ensure t 
  :config (exec-path-from-shell-initialize))
(use-package 
  smartparens-config 
  :config (show-smartparens-global-mode t) 
  ;(smartparens-global-strict-mode t) 
  (smartparens-global-mode t))
(use-package 
  projectile 
  :ensure t 
  :config (projectile-mode) 
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))
(use-package 
  helm 
  :ensure t 
  :config (global-set-key (kbd "M-x") #'helm-M-x) 
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks) 
  (global-set-key (kbd "C-x C-f") #'helm-find-files) 
  (helm-mode 1) 
  (define-key helm-find-files-map "\t" 'helm-execute-persistent-action))
(use-package 
  helm-projectile 
  :ensure t 
  :config (helm-projectile-on) 
  :after (projectile helm))
(use-package 
  flycheck 
  :ensure t 
  :config(global-flycheck-mode))
(use-package 
  company 
  :ensure t 
  :config (company-mode +1) 
  (global-company-mode +1))
(use-package 
  wakatime-mode 
  :ensure t 
  :init (setq wakatime-api-key "" wakatime-cli-path
	      "/usr/local/bin/wakatime"))
(use-package 
  dired-k 
  :ensure t)
(use-package 
  lsp-mode 
  :ensure t)
(use-package 
  ace-jump-mode 
  :ensure t)

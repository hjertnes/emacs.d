;; Inherit PATh from Shell; but only when not on windows.
(use-package 
  exec-path-from-shell 
  :ensure t 
  :if (is-not-windows) 
  :config (exec-path-from-shell-initialize))
;; Project management
(use-package 
  projectile 
  :ensure t 
  :init (setq projectile-indexing-method 'alien projectile-completion-system 'ivy) 
  :config (progn (projectile-mode) 
		 (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)))
;;
(use-package undo-tree :ensure t :config (global-undo-tree-mode))

;; Resize windows to golden ratio
(use-package
  golden-ratio
  :ensure t
  :config (golden-ratio-mode 1))
;; Eshell autojump
(use-package
  eshell-autojump
  :ensure t)
;; Check syntax on the fly
(use-package 
  flycheck 
  :ensure t 
  :config(global-flycheck-mode))
;; Auto completion
(use-package 
  company 
  :ensure t 
  :init (setq company-dabbrev-downcase 0 company-idle-delay 0) 
  :config (progn(company-mode +1) 
		(global-company-mode +1)))
;; Adds support for docker in Tramp
(use-package 
  docker-tramp 
  :ensure t)
;;Loading apps
(require 'core-apps)
;; Loading UI stuff
(require 'core-ui)
;; Loading Ivy/Counsel
(require 'core-ivy)
;; Loading keyboard related modules
(require 'core-keyboard)
(provide 'core)

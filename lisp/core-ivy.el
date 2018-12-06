;; Used to add history of last used M-x commands into Ivy.
(use-package 
  smex
  :ensure t 
  :config (smex-initialize))
;; Ivy for completion buffers
(use-package 
  counsel 
  :ensure t
  :config (progn (ivy-mode 1) 
           (global-set-key (kbd "C-s") 'swiper) 
           (global-set-key (kbd "M-x") 'counsel-M-x) 
           (global-set-key (kbd "C-x C-f") 'counsel-find-file) 
           (global-set-key (kbd "<f1> f") 'counsel-describe-function) 
           (global-set-key (kbd "<f1> v") 'counsel-describe-variable) 
           (global-set-key (kbd "<f1> l") 'counsel-find-library) 
           (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol) 
           (global-set-key (kbd "<f2> u") 'counsel-unicode-char)) 
  :init (setq  ivy-initial-inputs-alist nil ivy-use-virtual-buffers t ivy-count-format "(%d/d)"))
;; Integrate Ivy and Projectile
(use-package 
  counsel-projectile 
  :ensure t
  :after (counsel projectile)
  :config (counsel-projectile-mode +1))
;; Ivy interface for tramp
(use-package 
  counsel-tramp 
  :ensure t
  :after (counsel)
  :init (setq tramp-default-method "ssh") 
  :config (define-key global-map (kbd "C-c s") 'counsel-tramp))
(provide 'core-ivy)

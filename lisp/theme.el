;;nimbus theme
(use-package 
  nimbus-theme
  :config (load-theme 'nimbus t)
  :ensure t)
;;Afternoon theme
;; (use-package 
;;   afternoon-theme 
;;   :config (load-theme 'afternoon t) 
;;   :ensure t)
;; solarized theme
;; (use-package 
;;   solarized-theme
;;    :config (load-theme 'solarized-dark t)
;;   :ensure t)
;; Dracula theme
;; (use-package 
;;   dracula-theme
;;    :config (load-theme 'dracula t)
;;   :ensure t)
;;doom https://github.com/hlissner/emacs-doom-themes#install
;; (use-package all-the-icons :ensure t)
;; (use-package 
;;   doom-themes 
;;   :ensure t
;;   :after '(all-the-icons)
;;   :init (setq doom-themes-enable-bold t doom-themes-enable-italic t)
;;   :config (load-theme 'doom-one t) 
;;   (doom-themes-visual-bell-config) 
;;   (doom-themes-treemacs-config) 
;;   (doom-themes-org-config))
(provide 'theme)

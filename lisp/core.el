(use-package 
  magit 
  :ensure t)
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

;; Check syntax on the fly
(use-package 
  flycheck 
  :ensure t
  :init (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))
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
;; Smartparens
(use-package 
  smartparens 
  :ensure t 
  :config (progn 
	    (require 'smartparens-config) 
	    (smartparens-global-strict-mode +1) 
	    (show-smartparens-global-mode +1))
  :diminish smartparens-mode
  :bind (("C-M-k" . sp-kill-sexp-with-a-twist-of-lime) 
	 ("C-M-f" . sp-forward-sexp) 
	 ("C-M-b" . sp-backward-sexp) 
	 ("C-M-n" . sp-up-sexp) 
	 ("C-M-d" . sp-down-sexp) 
	 ("C-M-u" . sp-backward-up-sexp) 
	 ("C-M-p" . sp-backward-down-sexp) 
	 ("C-M-w" . sp-copy-sexp) 
	 ("M-s" . sp-splice-sexp) 
	 ("M-r" . sp-splice-sexp-killing-around) 
	 ("C-)" . sp-forward-slurp-sexp) 
	 ("C-}" . sp-forward-barf-sexp) 
	 ("C-(" . sp-backward-slurp-sexp) 
	 ("C-{" . sp-backward-barf-sexp) 
	 ("M-S" . sp-split-sexp) 
	 ("M-J" . sp-join-sexp) 
	 ("C-M-t" . sp-transpose-sexp)))
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
;; Use the dracule theme
(use-package 
  dracula-theme 
  :ensure t 
  :config (load-theme 'dracula t))
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
;; Use Ace-jump to move quickly
(use-package 
  ace-jump-mode 
  :ensure t 
  :bind (("C-c SPC" . ace-jump-mode) 
	 ("C-c C-u SPC" . ace-jump-char-mode) 
	 ("C-c C-u C-u SPC" . ace-jump-line-mode)))
;; Disable arrows etc to learn proper emacs movement
(use-package 
  no-easy-keys 
  :ensure t 
  :config (no-easy-keys 1))
(provide 'core)

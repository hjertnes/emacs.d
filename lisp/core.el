(use-package magit :ensure t)
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
(use-package smartparens :ensure t :config
  (progn
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
       ("C-M-t" . sp-transpose-sexp))
  )

;; Loading UI stuff
(require 'core-ui)
;; Loading Ivy/Counsel
(require 'core-ivy)

;; Loading keyboard related modules
(require 'core-keyboard)
(provide 'core)

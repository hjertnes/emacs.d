 ; Deft for nvALT stlye notes in Emacs
(use-package 
  deft 
  :ensure t
  :init (setq deft-extensions '("txt" "md" "org") deft-directory "~/txt/notes"
	      deft-use-filename-as-title t deft-file-naming-rules '((noslash . "-") 
								    (nospace . "-") 
								    (case-fn . downcase))))
;; The worlds best Git client
(use-package 
  magit
  :ensure t)
;; File browser app on the left, like Textmate or Sublime.
(use-package 
  neotree
  :ensure t)
;; Used to add history of last used M-x commands into Ivy.
(use-package 
  smex
  :ensure t 
  :config (smex-initialize))
;; Inherit PATh from Shell; but only when not on windows.
(if (is-not-windows) 
    (use-package 
      exec-path-from-shell 
      :ensure t
      :config (exec-path-from-shell-initialize)))
;; Use smartparens for matching deliminers etc
(use-package 
  smartparens-config
  :config (progn (show-smartparens-global-mode t) 
		 (smartparens-global-mode t)))
;; Project management
(use-package 
  projectile 
  :ensure t
  :init (setq projectile-indexing-method 'alien projectile-completion-system 'ivy) 
  :config (progn (projectile-mode) 
		 (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)))
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
  :config (counsel-projectile-mode +1))
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
;; Use Language Server Modules for Programming languages
(use-package 
  lsp-mode 
  :ensure t)
;; Language Server Company Mode Auto Completion
(use-package 
  company-lsp 
  :ensure t
  :config (push 'company-lsp company-backends))
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
(if (display-graphic-p)
(use-package 
  smart-mode-line 
  :ensure t
  :init (setq sml/no-confirm-load-theme t sml/theme 'atom-one-dark)
  :config (sml/setup))
(use-package 
  smart-mode-line 
  :ensure t
  :init (setq sml/no-confirm-load-theme t sml/theme 'dark)
  :config (sml/setup)))    
;; Adds support for docker in Tramp
(use-package 
  docker-tramp 
  :ensure t)
;; Ivy interface for tramp
(use-package 
  counsel-tramp 
  :ensure t
  :init (setq tramp-default-method "ssh") 
  :config (define-key global-map (kbd "C-c s") 'counsel-tramp))
;; Docker UI
(use-package 
  docker 
  :ensure t)
;; Stats for load time
(use-package 
  esup 
  :ensure t)

(use-package ace-window :ensure t :init (setq aw-dispatch-always t) :config (global-set-key (kbd "M-o") 'ace-window))
;;automagical window resize
(use-package 
  golden-ratio 
  :ensure t 
  :config (golden-ratio-mode 1))
(use-package 
  ace-window 
  :ensure t 
  :config (global-set-key (kbd "M-o") 'ace-window))
(use-package transient :ensure t)
(use-package 
  magit 
  :init (setq magit-completing-read-function 'ivy-completing-read) 
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
;; Adds suppnnort for docker in Tramp
(use-package 
  docker-tramp 
  :ensure t)
;; Smartparens
(use-package 
  smartparens 
  :ensure t 
  :config (progn 
	    (require 'smartparens-config)
	    (smartparens-global-strict-mode t)
	    ;; keybinding management
	    (define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
	    (define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
	    (define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-hybrid-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-p") 'sp-backward-hybrid-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
	    (define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
	    (define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)
	    (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
	    (define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)
	    (define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
	    (define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
	    (define-key smartparens-mode-map (kbd "C-M-<backspace>")
	      'sp-splice-sexp-killing-backward)
	    (define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)
	    (define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
	    (define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
	    (define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)
	    (define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
	    (define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)
	    (define-key smartparens-mode-map (kbd "C-\"") 'sp-change-inner)
	    (define-key smartparens-mode-map (kbd "M-i") 'sp-change-enclosing)
	    (bind-key "C-c f" 
		      (lambda () 
			(interactive) 
			(sp-beginning-of-sexp 2))
		      smartparens-mode-map)
	    (bind-key "C-c b" 
		      (lambda () 
			(interactive) 
			(sp-beginning-of-sexp -2))
		      smartparens-mode-map)

	    (bind-key "H-t" 'sp-prefix-tag-object smartparens-mode-map)
	    (bind-key "H-p" 'sp-prefix-pair-object smartparens-mode-map)
	    (bind-key "H-y" 'sp-prefix-symbol-object smartparens-mode-map)
	    (bind-key "H-h" 'sp-highlight-current-sexp smartparens-mode-map)
	    (bind-key "H-e" 'sp-prefix-save-excursion smartparens-mode-map)
	    (bind-key "H-s c" 'sp-convolute-sexp smartparens-mode-map)
	    (bind-key "H-s a" 'sp-absorb-sexp smartparens-mode-map)
	    (bind-key "H-s e" 'sp-emit-sexp smartparens-mode-map)
	    (bind-key "H-s p" 'sp-add-to-previous-sexp smartparens-mode-map)
	    (bind-key "H-s n" 'sp-add-to-next-sexp smartparens-mode-map)
	    (bind-key "H-s j" 'sp-join-sexp smartparens-mode-map)
	    (bind-key "H-s s" 'sp-split-sexp smartparens-mode-map)
	    (bind-key "H-s r" 'sp-rewrap-sexp smartparens-mode-map)
	    (defvar hyp-s-x-map)
	    (define-prefix-command 'hyp-s-x-map)
	    (bind-key "H-s x" hyp-s-x-map smartparens-mode-map)
	    (bind-key "H-s x x" 'sp-extract-before-sexp smartparens-mode-map)
	    (bind-key "H-s x a" 'sp-extract-after-sexp smartparens-mode-map)
	    (bind-key "H-s x s" 'sp-swap-enclosing-sexp smartparens-mode-map)
	    (bind-key "C-x C-t" 'sp-transpose-hybrid-sexp smartparens-mode-map)
	    (bind-key ";" 'sp-comment emacs-lisp-mode-map)
	    (bind-key [remap c-electric-backspace] 'sp-backward-delete-char
		      smartparens-strict-mode-map)))

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
		 (global-set-key (kbd "C-x C-b") 'ivy-switch-buffer) 
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
(use-package 
  treemacs 
  :ensure t 
  :defer t 
  :init (with-eval-after-load 'winum (define-key winum-keymap (kbd "M-0") #'treemacs-select-window)) 
  :config (progn 
	    (setq treemacs-collapse-dirs                 (if (executable-find "python3") 3 0)
		  treemacs-deferred-git-apply-delay      0.5 treemacs-display-in-side-window
		  t treemacs-eldoc-display                 t treemacs-file-event-delay
		  5000 treemacs-file-follow-delay             0.2 treemacs-follow-after-init
		  t treemacs-git-command-pipe              "" treemacs-goto-tag-strategy
		  'refetch-index treemacs-indentation                   2
		  treemacs-indentation-string            " " treemacs-is-never-other-window
		  nil treemacs-max-git-entries               5000 treemacs-no-png-images
		  nil treemacs-no-delete-other-windows       t treemacs-project-follow-cleanup
		  nil treemacs-persist-file                  (expand-file-name
							      ".cache/treemacs-persist"
							      user-emacs-directory)
		  treemacs-recenter-distance             0.1 treemacs-recenter-after-file-follow
		  nil treemacs-recenter-after-tag-follow     nil
		  treemacs-recenter-after-project-jump   'always
		  treemacs-recenter-after-project-expand 'on-distance treemacs-show-cursor
		  nil treemacs-show-hidden-files             t treemacs-silent-filewatch
		  nil treemacs-silent-refresh                nil treemacs-sorting
		  'alphabetic-desc treemacs-space-between-root-nodes      t
		  treemacs-tag-follow-cleanup            t treemacs-tag-follow-delay
		  1.5 treemacs-width                         35)

	    ;; The default width and height of the icons is 22 pixels. If you are
	    ;; using a Hi-DPI display, uncomment this to double the icon size.
	    ;;(treemacs-resize-icons 44)
	    (treemacs-follow-mode t) 
	    (treemacs-filewatch-mode t) 
	    (treemacs-fringe-indicator-mode t) 
	    (pcase (cons (not (null (executable-find "git"))) 
			 (not (null (executable-find "python3")))) 
	      (`(t . t) 
	       (treemacs-git-mode 'deferred)) 
	      (`(t . _) 
	       (treemacs-git-mode 'simple)))) 
  :bind (:map global-map
	      ("M-0"       . treemacs-select-window) 
	      ("C-x t 1"   . treemacs-delete-other-windows) 
	      ("C-x t t"   . treemacs) 
	      ("C-x t B"   . treemacs-bookmark) 
	      ("C-x t C-t" . treemacs-find-file) 
	      ("C-x t M-t" . treemacs-find-tag)))


(use-package 
  treemacs-projectile 
  :after treemacs 
  projectile 
  :ensure t)

(use-package 
  treemacs-icons-dired 
  :after treemacs 
  dired 
  :ensure t 
  :config (treemacs-icons-dired-mode))

(use-package 
  treemacs-magit 
  :after treemacs 
  magit 
  :ensure t)
(provide 'core)

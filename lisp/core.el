(use-package 
  golden-ratio 
  :ensure t 
  :config (golden-ratio-mode 1))
(use-package 
  ace-window 
  :ensure t 
  :config (global-set-key (kbd "M-o") 'ace-window))
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
  :config
  (progn 
  (require 'smartparens-config)
  
  (smartparens-global-mode t)
  (smartparens-global-strict-mode t)
  (add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode)

;;;;;;;;;;;;;;;;;;;;;;;;
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
(define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

(define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

(define-key smartparens-mode-map (kbd "C-\"") 'sp-change-inner)
(define-key smartparens-mode-map (kbd "M-i") 'sp-change-enclosing)

(bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
(bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)


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

(bind-key [remap c-electric-backspace] 'sp-backward-delete-char smartparens-strict-mode-map)

;;;;;;;;;;;;;;;;;;
;; pair management

(sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
(bind-key "C-(" 'sp---wrap-with-40 minibuffer-local-map)

(sp-with-modes 'org-mode
  (sp-local-pair "=" "=" :wrap "C-="))

(sp-with-modes 'textile-mode
  (sp-local-pair "*" "*")
  (sp-local-pair "_" "_")
  (sp-local-pair "@" "@"))

(sp-with-modes 'web-mode
  (sp-local-pair "{{#if" "{{/if")
  (sp-local-pair "{{#unless" "{{/unless"))

;;; tex-mode latex-mode
(sp-with-modes '(tex-mode plain-tex-mode latex-mode)
  (sp-local-tag "i" "\"<" "\">"))

;;; lisp modes
(sp-with-modes sp--lisp-modes
  (sp-local-pair "(" nil
                 :wrap "C-("
                 :pre-handlers '(my-add-space-before-sexp-insertion)
                 :post-handlers '(my-add-space-after-sexp-insertion)))

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (save-excursion
      (forward-char (sp-get-pair id :cl-l))
      (when (or (eq (char-syntax (following-char)) ?w)
                (looking-at (sp--get-opening-regexp)))
        (insert " ")))))

(defun my-add-space-before-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (save-excursion
      (backward-char (length id))
      (when (or (eq (char-syntax (preceding-char)) ?w)
                (and (looking-back (sp--get-closing-regexp))
                     (not (eq (char-syntax (preceding-char)) ?'))))
(insert " ")))))
  
   ))

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
(provide 'core)

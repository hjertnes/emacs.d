;; emacs package linter
(use-package 
  package-lint 
  :ensure t)
;; highlight TODO items in a buffer
(use-package 
  hl-todo 
  :ensure t
  :config (hl-todo-mode +1))
;; generate hugo blog post files from a org file
(use-package 
  ox-hugo 
  :ensure t 
  :init (setq org-hugo-front-matter-format 'yaml) 
  :after ox)
;; git client for emacs
(use-package 
  magit 
  :init (setq magit-completing-read-function 'ivy-completing-read) 
  :ensure t)
;; Inherit Path from Shell; but only when not on windows.
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
;; Show guides for different ident levels.
(use-package 
  indent-guide 
  :ensure t 
  :config (indent-guide-global-mode))
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
;; Disable arrows etc to learn proper emacs movement
(use-package 
  no-easy-keys 
  :ensure t 
  :config (no-easy-keys 1))
;;Snippet expainsion
(use-package yasnippet
  :ensure t
  :init (setq  yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (yas-global-mode 1)
  :bind (("M-s M-s" . yas-insert-snippet)("C-c y" . yas-expand)("C-c p" . yas-prev-field)("C-c n" . yas-next-field)))
;; toml
(use-package toml-mode :ensure t)
;; Use Ace-jump to move quickly
(use-package 
  ace-jump-mode 
  :ensure t 
  :bind (("C-c SPC" . ace-jump-mode) 
	 ("C-c C-u SPC" . ace-jump-char-mode) 
	 ("C-c C-u C-u SPC" . ace-jump-line-mode)))
;; ace-window: makes it easier to manage windows in emacs
(use-package 
  ace-window 
  :ensure t 
  :init (setq aw-dispatch-always t) 
  :config (global-set-key (kbd "M-o") 'ace-window))
;;eshell stuff
(use-package eshell-z :ensure t :config (add-hook 'eshell-mode-hook (defun my-eshell-mode-hook ()(require 'eshell-z))))
;; email
(use-package mu4e 
  :init (setq
	 mu4e-maildir (expand-file-name "~/Mail")
 mu4e-drafts-folder "/Drafts"
 mu4e-refile-folder "/Archive"
 mu4e-sent-folder   "/Sent Items"
 mu4e-trash-folder  "/Trash"
 mu4e-get-mail-command "mbsync -a"
 user-mail-address "me@hjertnes.me"
 user-full-name  "Eivind Hjertnes"
 smtpmail-default-smtp-server "smtp.fastmail.com"
 smtpmail-smtp-server "smtp.fastmail.com"
 smtpmail-smtp-service 587
 mu4e-bookmarks
 `(
   ("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
   ("maildir:/INBOX" "Inbox" ?i)
   )))
;; browser
(use-package w3m :ensure t)
;; Smart Parens Config - smart parens is a better way to manage expressions
(require 'core-sm)
;; Treemacs config - file expolorer.
(require 'core-treemacs)

(provide 'core)

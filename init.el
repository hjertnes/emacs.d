
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/") 
			 ("marmalade" . "http://marmalade-repo.org/packages/") 
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(dolist (package  
	 '(use-package 
	    smartparens)) 
  (unless (package-installed-p package) 
    (package-install package)))
(eval-when-compile 
  (require 'use-package))
;; End
(load "~/.emacs.d/pre.el")
(load "~/.emacs.d/core.el")
(load "~/.emacs.d/ui.el")
(load "~/.emacs.d/org.el")
(load "~/.emacs.d/apps.el")
(load "~/.emacs.d/langs.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (elisp-format cider taskpaper-mode writeroom-mode markdown-mode
						  omnisharp docker tide rjsx-mode js2-mode web-mode
						  company-tern lsp-python multi-term dashboard direx
						  neotree magit deft org-bullets nimbus-theme
						  page-break-lines all-the-icons smart-mode-line
						  rainbow-identifiers rainbow-delimiters hlinum
						  which-key indent-guide lsp-mode dired-k
						  wakatime-mode company flycheck editorconfig
						  helm-projectile helm projectile
						  exec-path-from-shell undo-tree smartparens
						  use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

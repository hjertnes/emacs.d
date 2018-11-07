 (setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook 
      (lambda () 
        (setq gc-cons-threshold 400000)))
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
(load "~/.emacsd/apps.el")
(load "~/.emacs.d/langs.el")

(defun new-empty-buffer ()
    "Create a new empty buffer."
    (interactive)
    (let (($buf (generate-new-buffer "untitled")))
      (switch-to-buffer $buf)
      (funcall initial-major-mode)
      (setq buffer-offer-save t)
      $buf))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elisp-format cider taskpaper-mode markdown-mode lsp-python magit deft rainbow-identifiers rainbow-delimiters which-key indent-guide ace-jump-mode lsp-mode company flycheck counsel-projectile counsel projectile exec-path-from-shell smex smartparens use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

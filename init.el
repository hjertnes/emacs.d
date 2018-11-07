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

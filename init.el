
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
(load "~/.emacs.d/scratch.el")

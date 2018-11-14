;; Eivind Hjertnes' Emacs configratuin
;; Set a large GC limit during startup and a smaller after, to make load time fast, but to avoid slow GC runs during use.
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook 
	  (lambda () 
	    (setq gc-cons-threshold 400000)))
;; Set up the emacs package manager
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/") 
			 ("marmalade" . "http://marmalade-repo.org/packages/") 
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
;; Install use-package(because it is used to load all other packages) and smartparens because its package name and what I will load are different
(dolist (package 
	 '(use-package 
	    smartparens)) 
  (unless (package-installed-p package) 
    (package-install package)))
;; load use-package
(eval-when-compile 
  (require 'use-package))
;; End
;; Configures things that are a part of emacs out of the box, and enables modes that come with emacs
(load "~/.emacs.d/pre.el")
;; Loads functions I use various places in my config
(load "~/.emacs.d/funcs.el")
;; Stuff I consider to be core to how I use emacs, but are neither UI or apps.
(load "~/.emacs.d/core.el")
;; Packages that alter visible stuff.
(load "~/.emacs.d/ui.el")
;; Apps, like for example magit
(load "~/.emacs.d/apps.el")
;; Programming languages
(load "~/.emacs.d/langs.el")
;; Load the csharp file on windows, a sepeate file because its messy. I use it at work.
(when (not(is-not-windows)) 
  (load "~/.emacs.d/csharp.el"))
;; Load personal.el if it exist, a file used to override settings per system. Ignored by git. Mostly used to override fonts per system
(when (file-exists-p "~/.emacs.d/personal.el") 
  (load "~/.emacs.d/personal.el"))

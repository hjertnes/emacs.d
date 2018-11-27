;; Eivind Hjertnes' Emacs configration
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; Configure Emacs GC
(require 'gc)
;; Set up the emacs package manager
(require 'package-manager)

;; Configures things that are a part of emacs out of the box, and enables modes that come with emacs
(require 'pre)
;; Loads functions I use various places in my config
(require 'funcs)
;; Stuff I consider to be core to how I use and want my emacs to be
(require 'core)
;; Programming languages
(require 'langs)
;; Load personal.el if it exist, a file used to override settings per system. Ignored by git. Mostly used to override fonts per system
(when (file-exists-p "~/.emacs.d/personal.el") 
  (load "~/.emacs.d/personal.el"))

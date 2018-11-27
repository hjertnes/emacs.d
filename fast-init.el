;; Eivind Hjertnes' Emacs configration
;; This is my fast init; it does not contain anything that is not a part of emacs, and I use it as my $EDITOR to have a good, but fast emacs config
;; Set a large GC limit during startup and a smaller after, to make load time fast, but to avoid slow GC runs during use.
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook 
	  (lambda () 
	    (setq gc-cons-threshold 400000)))
;; Configures things that are a part of emacs out of the box, and enables modes that come with emacs
(load "~/.emacs.d/pre.el")
;; Loads functions I use various places in my config
(load "~/.emacs.d/funcs.el")

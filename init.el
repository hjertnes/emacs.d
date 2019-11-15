;; Place all the custom junk in a custom.el file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Load configuration from Org Document
(require 'org)
(org-babel-load-file "~/.emacs.d/hjertnes.org")

;; Per computer overrides
(load "~/.emacs.d/personal.el")

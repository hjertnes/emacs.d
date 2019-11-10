;; Load configuration from Org Document
(require 'org)
(org-babel-load-file "~/.emacs.d/hjertnes.org")

;; Place all the custom junk in a custom.el file
(load (expand-file-name "custom.el" user-emacs-directory))

;; Per computer overrides
(load "~/.emacs.d/personal.el")


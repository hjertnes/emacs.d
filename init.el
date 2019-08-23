(require 'org)
(org-babel-load-file "~/.emacs.d/hjertnes.org")

(load "~/.emacs.d/personal.el")
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

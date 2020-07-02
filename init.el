;; Place All The Custom junk in a custom.el file
(defun create-if-not-exist(filename)
  (if (not(file-exists-p filename))
      (make-empty-file filename)))


(create-if-not-exist "~/.emacs.d/custom.el")
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Load configuration from Org Document
(require 'org)
(org-babel-load-file "~/.emacs.d/hjertnes.org")

;; Per computer overrides
(create-if-not-exist "~/.emacs.d/personal.el")
(load "~/.emacs.d/personal.el")

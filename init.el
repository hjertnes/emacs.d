;; Place All The Custom junk in a custom.el 
(defun create-if-not-exist(filename)
  (if (not(file-exists-p filename))
      (make-empty-file filename)))


(create-if-not-exist "~/.emacs.d/custom.el")
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Load configuration from Org Document.
;; iCloud sync can give the tangled hjertnes.el a newer mtime than
;; hjertnes.org, which defeats org-babel-load-file's tangle cache and
;; makes config edits silently do nothing. Delete the tangled file so
;; every startup re-tangles from hjertnes.org.
(require 'org)
(let ((tangled (expand-file-name "~/.emacs.d/hjertnes.el")))
  (when (file-exists-p tangled)
    (delete-file tangled)))
(org-babel-load-file "~/.emacs.d/hjertnes.org")

;; Per computer overrides
(create-if-not-exist "~/.emacs.d/personal.el")
(load "~/.emacs.d/personal.el")

;;; -*- lexical-binding: t; -*-

(defmacro hjertnes/with-error-guard (label &rest body)
  "Run BODY, logging a warning instead of aborting startup if it fails.
LABEL names the startup stage in the warning.  This keeps one broken
file from leaving Emacs silently half-configured: the remaining stages
still load, and the failure is visible in the *Warnings* buffer."
  (declare (indent 1))
  `(condition-case err
       (progn ,@body)
     (error (display-warning
             'init
             (format "%s failed: %s" ,label (error-message-string err))
             :error))))

;; Place All The Custom junk in a custom.el
(defun hjertnes/create-if-not-exist (filename)
  (if (not (file-exists-p filename))
      (make-empty-file filename)))

(hjertnes/with-error-guard "Loading custom.el"
  (hjertnes/create-if-not-exist "~/.emacs.d/custom.el")
  (setq custom-file "~/.emacs.d/custom.el")
  (load custom-file))

;; Load configuration from Org Document.
;; iCloud sync can give the tangled hjertnes.el a newer mtime than
;; hjertnes.org, which defeats org-babel-load-file's tangle cache and
;; makes config edits silently do nothing. Delete the tangled file so
;; every startup re-tangles from hjertnes.org.
(hjertnes/with-error-guard "Loading hjertnes.org"
  (require 'org)
  (let ((tangled (expand-file-name "~/.emacs.d/hjertnes.el")))
    (when (file-exists-p tangled)
      (delete-file tangled)))
  (org-babel-load-file "~/.emacs.d/hjertnes.org"))

;; Per computer overrides
(hjertnes/with-error-guard "Loading personal.el"
  (hjertnes/create-if-not-exist "~/.emacs.d/personal.el")
  (load "~/.emacs.d/personal.el"))

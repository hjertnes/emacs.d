;;; -*- lexical-binding: t; -*-

(declare-function org-babel-tangle-file "ob-tangle" (file &optional target-file lang-re))

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

(defun hjertnes/load-forms (file label)
  "Evaluate every top-level form in FILE, isolating failures.
Returns the number of forms that signalled.

`load' (and therefore `org-babel-load-file') evaluates a file as one
unit: the first form that signals aborts every remaining form in the
file, silently.  For a literate config that is a trap -- a form that
only fails in a GUI session (a missing font, a theme, `server-mode',
`exec-path-from-shell') skips all ~60 blocks after it, and startup still
looks clean because the rest of init.el keeps going.  Evaluating form by
form contains the damage to the one broken form and names it in
*Warnings*.  Forms are read and evaluated one at a time in order, with
lexical binding, exactly as `load' would."
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (let ((eof (make-symbol "eof"))
          (bad (make-symbol "bad"))
          (failures 0)
          form start)
      (while (progn
               (setq start (point))
               ;; Two escape routes for a failed read: `end-of-file' (listed
               ;; first) feeds the truncation check below, covering both the
               ;; buffer being legitimately spent and an unclosed paren that
               ;; swallowed the rest of the file; any other read error -- a
               ;; stray `)', a bad `#' token -- yields `bad' so one unreadable
               ;; token costs its own line instead of aborting every
               ;; remaining form.
               (not (eq (setq form (condition-case nil
                                       (read (current-buffer))
                                     (end-of-file eof)
                                     (error bad)))
                        eof)))
        (if (eq form bad)
            (progn
              (setq failures (1+ failures))
              (display-warning
               'init
               (format "%s: unreadable token on line %d of %s -- skipped one line"
                       label (line-number-at-pos) (file-name-nondirectory file))
               :error)
              ;; Guaranteed progress: skip the offending line and resume
              ;; reading; at end-of-buffer the next read returns `eof'.
              (forward-line 1))
          (let ((line (line-number-at-pos)))
            (condition-case err
                (eval form t)
              (error
               (setq failures (1+ failures))
               (display-warning
                'init
                (format "%s: top-level form ending on line %d of %s failed: %s"
                        label line (file-name-nondirectory file)
                        (error-message-string err))
                :error))))))
      ;; `read' signals `end-of-file' both when the buffer is legitimately spent and when a
      ;; form is unbalanced -- an unclosed paren swallows the rest of the file and then hits
      ;; the real end. Treating the two alike is what made a single stray paren silently drop
      ;; every block after it while this function still returned 0 failures, so startup looked
      ;; clean. Distinguish them by where the failed read began: anything but whitespace and
      ;; comments left after it means the file was truncated, not finished.
      (goto-char start)
      ;; Skip whitespace and `;' comments by hand: a temp buffer is in fundamental-mode, so
      ;; `forward-comment' has no Lisp syntax table to work from and treats a trailing comment
      ;; as leftover code.
      (while (progn
               (skip-chars-forward " \t\n\f")
               (when (eq (char-after) ?\;)
                 (forward-line 1)
                 t)))
      (unless (eobp)
        (setq failures (1+ failures))
        (display-warning
         'init
         (format "%s: unbalanced expression starting on line %d of %s -- \
everything from there on was NOT loaded"
                 label (line-number-at-pos) (file-name-nondirectory file))
         :error))
      failures)))

(defun hjertnes/tangle-config (source tangled)
  "Tangle SOURCE to a temp file, then rename it over TANGLED.
Never deletes TANGLED first: when SOURCE is evicted by iCloud or
otherwise unreadable, the previous startup's working TANGLED survives
instead of leaving no config at all.  Tangling to a fresh temp file
also defeats org-babel's mtime tangle cache, which iCloud sync used to
confuse by giving TANGLED a newer mtime than SOURCE."
  (let ((tmp (make-temp-file "hjertnes-tangle-" nil ".el")))
    (unwind-protect
        (progn
          ;; An evicted/missing source must error here: org-babel-tangle-file
          ;; would happily visit a nonexistent file and "tangle" zero blocks.
          (unless (file-readable-p source)
            (error "Config source %s is not readable" source))
          (org-babel-tangle-file source tmp
                                 "\\`\\(?:emacs-lisp\\|elisp\\)\\'")
          ;; Same trap from the other side: an empty tangle is never an
          ;; improvement on yesterday's working config.
          (when (zerop (file-attribute-size (file-attributes tmp)))
            (error "Tangling %s produced no output" source))
          (rename-file tmp tangled t))
      (when (file-exists-p tmp)
        (delete-file tmp)))))

;; Load configuration from Org Document.
;; Tangle and load are done by hand rather than via org-babel-load-file
;; so each block can fail on its own (see hjertnes/load-forms).
(hjertnes/with-error-guard "Loading hjertnes.org"
  (require 'org)
  (require 'ob-tangle)
  (let ((source (expand-file-name "~/.emacs.d/hjertnes.org"))
        (tangled (expand-file-name "~/.emacs.d/hjertnes.el")))
    (hjertnes/tangle-config source tangled)
    (let ((failures (hjertnes/load-forms tangled "hjertnes.org")))
      ;; Loud sentinel: a truncated or partially failed load must never
      ;; look like a clean startup.
      (message "hjertnes.org loaded: %d form%s failed"
               failures (if (= failures 1) "" "s")))))

;; Per computer overrides
(hjertnes/with-error-guard "Loading personal.el"
  (hjertnes/create-if-not-exist "~/.emacs.d/personal.el")
  (load "~/.emacs.d/personal.el"))

;;; load-forms-test.el --- hermetic tests for hjertnes/load-forms -*- lexical-binding: t; -*-

;; Run with: emacs --batch -l tests/load-forms-test.el  (or `make test')
;;
;; Reads init.el form by form and evaluates ONLY the hjertnes/load-forms
;; defun -- no full startup, no packages -- then feeds the loader temp
;; files containing the three read-failure shapes: a stray close paren,
;; a bad `#' token, and an unclosed open paren.  Exits non-zero when any
;; expectation fails.  `make smoke' is the full-startup complement.

(defvar load-forms-test--here
  (file-name-directory (or load-file-name buffer-file-name))
  "Directory this test file lives in.")

(defvar load-forms-test--failed 0
  "Number of failed checks.")

(defun load-forms-test--extract (name)
  "Read init.el and evaluate only the (defun NAME ...) form."
  (with-temp-buffer
    (insert-file-contents (expand-file-name "../init.el" load-forms-test--here))
    (goto-char (point-min))
    (let ((eof (make-symbol "eof"))
          form found)
      (while (and (not found)
                  (not (eq (setq form (condition-case nil
                                          (read (current-buffer))
                                        (end-of-file eof)))
                           eof)))
        (when (and (eq (car-safe form) 'defun)
                   (eq (nth 1 form) name))
          (eval form t)
          (setq found t)))
      (unless found
        (message "FAIL: (defun %s ...) not found in init.el" name)
        (kill-emacs 1)))))

(defun load-forms-test--extract-loader ()
  "Evaluate the hjertnes/load-forms defun from init.el."
  (load-forms-test--extract 'hjertnes/load-forms))

(defun load-forms-test--check (name got want)
  "Record and report whether GOT equals WANT for the check NAME."
  (if (equal got want)
      (message "ok: %s" name)
    (setq load-forms-test--failed (1+ load-forms-test--failed))
    (message "FAIL: %s -- got %S, want %S" name got want)))

(defun load-forms-test--run (content)
  "Run hjertnes/load-forms over a temp file holding CONTENT; return failures."
  (let ((file (make-temp-file "load-forms-test-" nil ".el" content)))
    (unwind-protect
        (hjertnes/load-forms file "load-forms-test")
      (delete-file file))))

(load-forms-test--extract-loader)

;; (a) A stray close paren costs one failure; the form after it still runs.
(let ((failures (load-forms-test--run
                 "(setq load-forms-test-a1 1)\n)\n(setq load-forms-test-a2 2)\n")))
  (load-forms-test--check "stray close paren counts one failure" failures 1)
  (load-forms-test--check "form after the stray paren still evaluates"
                          (and (boundp 'load-forms-test-a2)
                               (symbol-value 'load-forms-test-a2))
                          2))

;; (b) A bad `#' token between two good forms: both good forms evaluate.
(let ((failures (load-forms-test--run
                 "(setq load-forms-test-b1 1)\n#foo\n(setq load-forms-test-b2 2)\n")))
  (load-forms-test--check "bad # token counts one failure" failures 1)
  (load-forms-test--check "form before the bad token evaluated"
                          (and (boundp 'load-forms-test-b1)
                               (symbol-value 'load-forms-test-b1))
                          1)
  (load-forms-test--check "form after the bad token evaluated"
                          (and (boundp 'load-forms-test-b2)
                               (symbol-value 'load-forms-test-b2))
                          2))

;; (c) An unclosed open paren is reported via the existing truncation branch.
(let ((failures (load-forms-test--run
                 "(setq load-forms-test-c1 1)\n(setq load-forms-test-c2\n")))
  (load-forms-test--check "unclosed open paren counts one failure" failures 1)
  (load-forms-test--check "form before the truncation evaluated"
                          (and (boundp 'load-forms-test-c1)
                               (symbol-value 'load-forms-test-c1))
                          1))

;; (d) hjertnes/tangle-config on an unreadable org source leaves the
;;     pre-existing tangled file in place -- yesterday's working config
;;     must survive an iCloud eviction of hjertnes.org.
(require 'ob-tangle)
(load-forms-test--extract 'hjertnes/tangle-config)
(let ((tangled (make-temp-file "load-forms-test-tangled-" nil ".el"
                               ";; yesterday's working config\n")))
  (unwind-protect
      (progn
        (load-forms-test--check
         "tangling an unreadable org source signals"
         (condition-case nil
             (progn (hjertnes/tangle-config
                     (expand-file-name "load-forms-test-missing.org"
                                       temporary-file-directory)
                     tangled)
                    nil)
           (error 1))
         1)
        (load-forms-test--check
         "pre-existing tangled config survives the failed tangle"
         (with-temp-buffer
           (insert-file-contents tangled)
           (buffer-string))
         ";; yesterday's working config\n"))
    (when (file-exists-p tangled)
      (delete-file tangled))))

(if (zerop load-forms-test--failed)
    (message "load-forms-test: all checks passed")
  (message "load-forms-test: %d check(s) FAILED" load-forms-test--failed)
  (kill-emacs 1))

;;; load-forms-test.el ends here

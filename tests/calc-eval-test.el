;;; calc-eval-test.el --- batch test for hjertnes/calc-eval-region -*- lexical-binding: t; -*-

;; Run with: emacs --batch -l tests/calc-eval-test.el  (or `make test')
;;
;; Tangles hjertnes.org to a temp file, evaluates ONLY the
;; hjertnes/calc-eval-region defun -- no full startup, no packages --
;; and asserts that an expression calc cannot parse signals `user-error'
;; rather than crashing with `wrong-type-argument', in both the message
;; branch (no prefix arg) and the insert branch (prefix arg).

(require 'org)
(require 'ob-tangle)
(require 'calc)

(defvar calc-eval-test--here
  (file-name-directory (or load-file-name buffer-file-name))
  "Directory this test file lives in.")

(defvar calc-eval-test--failed 0
  "Number of failed checks.")

(defun calc-eval-test--check (name ok)
  "Record and report whether the check NAME passed (OK non-nil)."
  (if ok
      (message "ok: %s" name)
    (setq calc-eval-test--failed (1+ calc-eval-test--failed))
    (message "FAIL: %s" name)))

;; Tangle the org config and evaluate only the one defun under test.
(let ((source (expand-file-name "../hjertnes.org" calc-eval-test--here))
      (tangled (make-temp-file "calc-eval-test-" nil ".el")))
  (unwind-protect
      (progn
        (org-babel-tangle-file source tangled
                               "\\`\\(?:emacs-lisp\\|elisp\\)\\'")
        (with-temp-buffer
          (insert-file-contents tangled)
          (goto-char (point-min))
          (let ((eof (make-symbol "eof"))
                form found)
            (while (and (not found)
                        (not (eq (setq form (condition-case nil
                                                (read (current-buffer))
                                              (end-of-file eof)))
                                 eof)))
              (when (and (eq (car-safe form) 'defun)
                         (eq (nth 1 form) 'hjertnes/calc-eval-region))
                (eval form t)
                (setq found t)))
            (unless found
              (message "FAIL: (defun hjertnes/calc-eval-region ...) not found")
              (kill-emacs 1)))))
    (delete-file tangled)))

;; A valid expression still evaluates in the message branch.
(with-temp-buffer
  (insert "2+3")
  (calc-eval-test--check "valid expression evaluates"
                         (condition-case nil
                             (progn (hjertnes/calc-eval-region
                                     nil (point-min) (point-max))
                                    t)
                           (error nil))))

;; An unparsable expression signals user-error, not wrong-type-argument.
(with-temp-buffer
  (insert "2+")
  (calc-eval-test--check "unparsable expression signals user-error (message branch)"
                         (condition-case nil
                             (progn (hjertnes/calc-eval-region
                                     nil (point-min) (point-max))
                                    nil)
                           (user-error t)
                           (error nil))))

(with-temp-buffer
  (insert "2+")
  (calc-eval-test--check "unparsable expression signals user-error (insert branch)"
                         (condition-case nil
                             (progn (hjertnes/calc-eval-region
                                     '(4) (point-min) (point-max))
                                    nil)
                           (user-error t)
                           (error nil)))
  (calc-eval-test--check "insert branch inserted nothing on failure"
                         (equal (buffer-string) "2+")))

(if (zerop calc-eval-test--failed)
    (message "calc-eval-test: all checks passed")
  (message "calc-eval-test: %d check(s) FAILED" calc-eval-test--failed)
  (kill-emacs 1))

;;; calc-eval-test.el ends here

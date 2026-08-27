;;; state-dirs-test.el --- generated state stays out of ~/Documents -*- lexical-binding: t; -*-

;; Run with: emacs --batch -l tests/state-dirs-test.el  (or `make test')
;;
;; Loads early-init.el (where every relocation is declared) and asserts
;; that the package directory, the eln-cache, and the transient/emojify
;; state files all resolve OUTSIDE the iCloud-synced ~/Documents tree.
;; This repo lives inside that tree; any of these landing back in it
;; recreates the eviction/conflict-copy hazard the relocations exist for.

(defvar state-dirs-test--here
  (file-name-directory (or load-file-name buffer-file-name))
  "Directory this test file lives in.")

(defvar state-dirs-test--failed 0
  "Number of failed checks.")

(load (expand-file-name "../early-init.el" state-dirs-test--here) nil t)

(defvar state-dirs-test--documents
  (file-truename (expand-file-name "~/Documents/"))
  "The iCloud-synced root nothing generated may live under.")

(defun state-dirs-test--check (name path)
  "Fail when PATH (a file or directory) resolves under ~/Documents."
  (let ((true (file-truename (expand-file-name path))))
    (if (string-prefix-p state-dirs-test--documents true)
        (progn
          (setq state-dirs-test--failed (1+ state-dirs-test--failed))
          (message "FAIL: %s resolves inside ~/Documents: %s" name true))
      (message "ok: %s -> %s" name true))))

(state-dirs-test--check "package-user-dir" package-user-dir)
(state-dirs-test--check "transient-levels-file" transient-levels-file)
(state-dirs-test--check "transient-values-file" transient-values-file)
(state-dirs-test--check "transient-history-file" transient-history-file)
(state-dirs-test--check "emojify-emojis-dir" emojify-emojis-dir)
(when (boundp 'native-comp-eln-load-path)
  (state-dirs-test--check "native-comp eln cache (user entry)"
                          (car native-comp-eln-load-path)))

(if (zerop state-dirs-test--failed)
    (message "state-dirs-test: all checks passed")
  (message "state-dirs-test: %d check(s) FAILED" state-dirs-test--failed)
  (kill-emacs 1))

;;; state-dirs-test.el ends here

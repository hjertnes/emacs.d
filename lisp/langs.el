;; pug support
(use-package 
  pug-mode 
  :ensure t)
;; Markdown support
(use-package 
  markdown-mode 
  :ensure t 
  :commands (markdown-mode gfm-mode) 
  :mode (("README\\.md\\'" . gfm-mode) 
	 ("\\.txt\\'" . markdown-mode) 
	 ("\\.md\\'" . markdown-mode) 
	 ("\\.markdown\\'" . markdown-mode)) 
  :init (setq markdown-command "multimarkdown"))
;; Taskpaper support
(use-package 
  taskpaper-mode 
  :ensure t)
;; Format emacs lisp files
(use-package 
  elisp-format 
  :ensure t)
;; Add support for Cucumber files
(use-package 
  feature-mode 
  :ensure t 
  :config (setq feature-default-langauge "fi"))
;; Dockerfiles
(use-package 
  dockerfile-mode 
  :ensure t 
  :config (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))
;; Docker-compose files
(use-package 
  docker-compose-mode 
  :ensure t)					; Code for auto completion etc with .NET
;; Set the omnisharp server path manually on windows, because that piece of shit is weird, and only work this way.
(defun csharp-config () 
  (add-to-list 'company-backends #'company-omnisharp) 
  (add-hook 'csharp-mode-hook 
	    (lambda() 
	      (omnisharp-mode) 
	      (company-mode) 
	      (flycheck-mode) 
	      (setq indent-tabs-mode nil company-idle-delay .1 c-syntactic-indentation t
		    c-basic-offset 4 truncate-lines t tab-width 4) 
	      (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring) 
	      (local-set-key (kbd "C-c C-c") 'recompile))))
(use-package 
  omnisharp 
  :ensure t 
  :if (is-windows) 
  :init (setq omnisharp-server-executable-path  "C:\\Bin\\omnisharp-roslyn\\OmniSharp.exe") 
  :config (csharp-config))
(use-package 
  omnisharp 
  :ensure t 
  :if (is-not-windows) 
  :config (csharp-config))
;; Editing web stuff(html, css etc)
(use-package 
  web-mode 
  :ensure)
(use-package 
  json-mode 
  :ensure)


(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :init
  (setq-default js2-concat-multiline-strings 'eol)
  (setq-default js2-global-externs '("module" "require" "setTimeout" "clearTimeout" "setInterval"
                                     "clearInterval" "location" "__dirname" "console" "JSON" "window"
                                     "process" "fetch"))
  (setq-default js2-strict-inconsistent-return-warning nil)
  :bind (:map js2-mode-map
              ("M-r"        . node-js-eval-region-or-buffer)
              ("M-R"        . refresh-chrome)
              ("M-s-<up>"   . js2r-move-line-up)
              ("M-s-<down>" . js2r-move-line-down)
              ("C-<left>"   . js2r-forward-barf)
              ("C-<right>"  . js2r-forward-slurp)
              ("M-m S"      . js2r-split-string))
  :config
  (use-package prettier-js :ensure t)
  (use-package rjsx-mode :ensure t
    :mode "\\.jsx\\'"
    :magic ("import React" . rjsx-mode))
  (use-package js2-refactor :ensure t)
  (use-package json-mode :ensure t)
  (use-package nodejs-repl :ensure t)
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (add-hook 'js2-mode-hook
            '(lambda ()
               (js2-refactor-mode)
               (js2r-add-keybindings-with-prefix "M-m")
               (key-chord-define js2-mode-map ";;" (λ (save-excursion (move-end-of-line nil) (insert ";"))))
               (key-chord-define js2-mode-map ",," (λ (save-excursion (move-end-of-line nil) (insert ","))))

               (define-key js2-mode-map (kbd ";")
                 (λ (if (looking-at ";")
                        (forward-char)
                      (funcall 'self-insert-command 1))))

               ;; Overwrite this function to output to minibuffer
               (defun nodejs-repl-execute (command &optional buf)
                 "Execute a command and output the result to minibuffer."
                 (let ((ret (nodejs-repl--send-string (concat command "\n"))))
                   (setq ret (replace-regexp-in-string nodejs-repl-ansi-color-sequence-re "" ret))
                   ;; delete inputs
                   (setq ret (replace-regexp-in-string "\\(\\w\\|\\W\\)+\r\r\n" "" ret))
                   (setq ret (replace-regexp-in-string "\r" "" ret))
                   (setq ret (replace-regexp-in-string "\n.*\\'" "" ret))
                   (setq ret (replace-regexp-in-string "\nundefined\\'" "" ret))
                   (message ret)))

               (defadvice nodejs-repl (after switch-back activate)
                 (delete-window)))))



(use-package company-tern :ensure t :config (progn (add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))))
;; Clojure support
(use-package 
  clojure-mode 
  :ensure t)
;; Clojure Repl integration and much more
(use-package 
  cider 
  :ensure t 
  :config (progn (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion) 
		 (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion) 
		 (add-hook 'after-save-hook 
			   (lambda() 
			     (when (eq major-mode 'clojure-mode) 
			       (cider-load-buffer))))))

(provide 'langs)

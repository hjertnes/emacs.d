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
  :ensure t)		      ; Code for auto completion etc with .NET
;; Set the omnisharp server path manually on windows, because that piece of shit is weird, and only work this way.
(defun csharp-config () 
  (add-to-list 'company-backends #'company-omnisharp) 
  (add-hook 'csharp-mode-hook (lambda() 
				(omnisharp-mode) 
				(company-mode) 
				(flycheck-mode) 
				(setq indent-tabs-mode nil company-idle-delay .1
				      c-syntactic-indentation t c-basic-offset 4 truncate-lines t
				      tab-width 4) 
				(local-set-key (kbd "C-c r r")
					       'omnisharp-run-code-action-refactoring) 
				(local-set-key (kbd "C-c C-c") 'recompile))))
(use-package 
  omnisharp 
  :ensure t 
  :init (setq omnisharp-server-executable-path(cond((is-windows)
						    "C:\\Bin\\omnisharp-roslyn\\OmniSharp.exe") 
						   ((is-mac)  "/opt/omnisharp-roslyn/OmniSharp.exe") 
						   ((is-linux)
						    "/opt/omnisharp-roslyn/OmniSharp.exe"))) 
  :config (csharp-config))
;; Editing web stuff(html, css etc)
(use-package 
  web-mode 
  :ensure)
(use-package 
  json-mode 
  :ensure)
(use-package 
  js2-mode 
  :ensure t 
  :mode "\\.js\\'" 
  :interpreter "node" 
  :init (setq-default js2-concat-multiline-strings 'eol) 
  (setq-default js2-global-externs '("module" "require" "setTimeout" "clearTimeout" "setInterval"
				     "clearInterval" "location" "__dirname" "console" "JSON"
				     "window" "process" "fetch")) 
  (setq-default js2-strict-inconsistent-return-warning nil) 
  :config (use-package 
	    prettier-js 
	    :ensure t) 
  (use-package 
    rjsx-mode 
    :ensure t 
    :mode "\\.js\\'" 
    :magic ("import React" . rjsx-mode)))
(use-package 
  scss-mode 
  :ensure t)
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
		 (add-hook 'after-save-hook (lambda() 
					      (when (eq major-mode 'clojure-mode) 
						(cider-load-buffer))))))
(use-package 
  org 
  :ensure t 
  :pin org)
(use-package 
  org-bullets 
  :ensure t 
  :config (add-hook 'org-mode-hook 'org-bullets-mode))
(use-package 
  org-beautify-theme 
  :ensure t)
(provide 'langs)

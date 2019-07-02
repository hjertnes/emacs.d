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
  :ensure t)
;; Code for auto completion etc with .NET
(require 'langs-net)
;; Editing web stuff(html, css javascript, json etc)
(require 'langs-web)
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
						(cider-load-buffer
						 ))))))
(require 'langs-org)
(provide 'langs)

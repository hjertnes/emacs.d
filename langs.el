;; Python support through LSP
(use-package 
  lsp-python 
  :ensure t
  :init (add-hook 'python-mode-hook #'lsp-python-enable))
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
;; Editing web stuff(html, css etc)
(use-package 
  web-mode 
  :ensure t
  :config (progn (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
		 (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))))
;; Plain Javascript support
(use-package 
  js3-mode 
  :ensure t
  :init (setq js3-auto-indent-p t js3-enter-indents-newline t js3-indent-on-enter-key t))
;; React support
(use-package 
  rjsx-mode 
  :ensure t)
;; LSP server for JavaScript
;; remember: npm i -g javascript-typescript-langserver
(use-package 
  lsp-javascript-typescript 
  :ensure t
  :config (progn (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
		 (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable)
		 (add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable)
		 (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable)))
;; Csharp Mode
(use-package csharp-mode :ensure t)
;; Code for auto completion etc with .NET
;; Set the omnisharp server path manually on windows, because that piece of shit is weird, and only work this way.
(when (is-windows) 
  (use-package 
    omnisharp 
    :ensure t 
    :init (setq omnisharp-server-executable-path "C:\\Bin\\omnisharp-roslyn\\OmniSharp.exe")) 
  :config (progn (add-to-list 'company-backends #'company-omnisharp) 
		 (add-hook 'csharp-mode-hook 
			   (lambda() 
			     (omnisharp-mode) 
			     (company-mode) 
			     (flycheck-mode) 
			     (setq indent-tabs-mode nil c-syntactic-indentation t c-basic-offset 4
				   truncate-lines t tab-width 4) 
			     (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring) 
			     (local-set-key (kbd "C-c C-c") 'recompile)))))

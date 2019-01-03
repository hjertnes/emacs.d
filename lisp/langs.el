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
;;Csharp support on windows
(require 'langs-csharp)
;; JS and Web modules
(require 'langs-web)
;; Clojure modules
(require 'langs-clojure)
(provide 'langs)

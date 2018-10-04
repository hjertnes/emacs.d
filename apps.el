
(use-package 
  deft 
  :ensure t 
  :init (setq deft-extensions '("txt" "md" "org") deft-directory "~/txt/notes"
	      deft-use-filename-as-title t deft-file-naming-rules '((noslash . "-") 
								    (nospace . "-") 
								    (case-fn . downcase))))
(use-package 
  magit 
  :ensure t)
(use-package 
  neotree 
  :ensure t 
  :init (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
(use-package 
  direx 
  :ensure t)
(use-package 
  dashboard 
  :ensure t 
  :config (dashboard-setup-startup-hook) 
  :init (setq dashboard-items '((recents  . 10) 
				(projects . 10))))
(use-package 
  multi-term 
  :ensure t 
  :init (setq multi-term-program "/bin/zsh") 
  :config (add-hook 'term-mode-hook 
		    (lambda () 
		      (setq term-buffer-maximum-size 0) 
		      (setq show-trailing-whitespace nil) 
		      (autopair-mode -1) 
		      (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev)) 
		      (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next)) 
		      (define-key term-raw-map (kbd "C-y") 'term-paste))))

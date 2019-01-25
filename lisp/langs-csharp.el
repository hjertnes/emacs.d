;; Code for auto completion etc with .NET
;; Set the omnisharp server path manually on windows, because that piece of shit is weird, and only work this way.
(use-package 
  omnisharp 
  :ensure t 
  :init (setq omnisharp-server-executable-path (if (is-windows) "C:\\Bin\\omnisharp-roslyn\\OmniSharp.exe" "/usr/local/bin/omnisharp"))
  :config (progn (add-to-list 'company-backends #'company-omnisharp) 
		 (add-hook 'csharp-mode-hook 
			   (lambda() 
			     (omnisharp-mode) 
			     (company-mode) 
			     (flycheck-mode) 
			     (setq indent-tabs-mode nil
			      company-idle-delay .1
				   c-syntactic-indentation t c-basic-offset 4
				   truncate-lines t tab-width 4) 
			     (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring) 
			     (local-set-key (kbd "C-c C-c") 'recompile)))))
(provide 'langs-csharp)

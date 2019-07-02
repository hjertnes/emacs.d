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
(provide 'langs-net)

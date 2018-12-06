;; Use Language Server Modules for Programming languages
(use-package 
  lsp-mode 
  :ensure t)
;; Language Server Company Mode Auto Completion
(use-package 
  company-lsp 
  :ensure t
  :after (lsp-mode company)
  :config (push 'company-lsp company-backends))
(provide 'core-lsp)

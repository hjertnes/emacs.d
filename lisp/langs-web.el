;; Editing web stuff(html, css etc)
(use-package 
  web-mode 
  :ensure)
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
(provide 'langs-web)

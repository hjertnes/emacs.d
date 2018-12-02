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
  js2-mode 
  :ensure t)
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

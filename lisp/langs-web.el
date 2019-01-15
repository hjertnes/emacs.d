;; Editing web stuff(html, css etc)
(use-package 
  web-mode 
  :ensure)
(use-package 
  json-mode 
  :ensure)
(use-package 
  js2-mode 
  :ensure)

;; React support
(use-package 
  rjsx-mode 
  :ensure t)
(use-package langs-js :after (web-mode json-mode js2-mode flycheck))
(provide 'langs-web)

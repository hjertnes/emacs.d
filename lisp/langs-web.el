(use-package 
  web-mode 
  :ensure)
(use-package 
  json-mode 
  :ensure)
(use-package 
  js2-mode 
  :ensure t 
  :mode "\\.js\\'" 
  :interpreter "node" 
  :init (setq-default js2-concat-multiline-strings 'eol) 
  (setq-default js2-global-externs '("module" "require" "setTimeout" "clearTimeout" "setInterval"
				     "clearInterval" "location" "__dirname" "console" "JSON"
				     "window" "process" "fetch")) 
  (setq-default js2-strict-inconsistent-return-warning nil) 
  :config (use-package 
	    prettier-js 
	    :ensure t) 
  (use-package 
    rjsx-mode 
    :ensure t 
    :mode "\\.js\\'" 
    :magic ("import React" . rjsx-mode)))
(use-package 
  scss-mode 
  :ensure t)
(provide 'langs-web)

(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook 
	  (lambda () 
	    (setq gc-cons-threshold 400000)))
(provide 'gc)

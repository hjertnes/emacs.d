;; Set my font: Source Code Pro.

(set-face-attribute 'default nil 
		    :family "Source Code Pro" 
		    :height 100 
		    :weight 'normal 
		    :width 'normal)



(autoload 'ibuffer "ibuffer" "List buffers." t)
;; Setting emacs settings that are not a part of third party modules
(require 'pre-setq)
;; Enabling built in emacs modes
(require 'pre-modes)
(provide 'pre)

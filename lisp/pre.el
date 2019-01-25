;; Set my font: Source Code Pro.

(set-face-attribute 'default nil 
		    :family "Fira Code" 
		    :height 120 
		    :weight 'normal 
		    :width 'normal)



;; Bind CxCb to iBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;; Setting emacs settings that are not a part of third party modules
(require 'pre-setq)
;; Enabling built in emacs modes
(require 'pre-modes)
(provide 'pre)

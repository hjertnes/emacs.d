(setq ns-use-native-fullscreen t projectile-project-search-path '("~/Code/")
      mac-right-option-modifier 'super ns-function-modifier 'hyper mac-right-command-modifier 'super
      create-lockfiles nil make-backup-files nil auto-save-default nil inhibit-startup-message t
      initial-scratch-message nil select-enable-clipboard t)
(set-face-attribute 'default nil 
		    :family "Source Code Pro" 
		    :height 130 
		    :weight 'normal 
		    :width 'normal)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(electric-indent-mode +1)
(electric-pair-mode 1)
(global-hl-line-mode 1)
(global-visual-line-mode 1)
(global-prettify-symbols-mode 1)
(show-paren-mode 1)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
					;(set-fontset-font "fontset-default" (cons page-break-lines-char page-break-lines-char) (face-attribute 'default :family))
(global-set-key (kbd "C-z") 'undo)

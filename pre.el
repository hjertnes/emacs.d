(setq
 initial-major-mode (quote text-mode)
 org-support-shift-select t
 org-agenda-files (list "~/txt/org/next.org")
 tab-with 4
 ns-use-native-fullscreen t
 projectile-project-search-path '("~/Code/")
 indent-tabs-mode nil
 create-lockfiles nil
 make-backup-files nil
 auto-save-default nil
 inhibit-startup-message t
 initial-scratch-message nil
 select-enable-clipboard t)
(set-face-attribute 'default nil 
					:family "Source Code Pro" 
					:height 120 
					:weight 'normal 
					:width 'normal)
(global-auto-revert-mode 1)
(auto-save-visited-mode 1)
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
(global-set-key (kbd "C-z") 'undo)
(global-display-line-numbers-mode +1)
;(global-highlight-changes-mode +1)
(global-hi-lock-mode +1)
(column-number-mode +1)

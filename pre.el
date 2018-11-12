(setq
 ;; A huge undo buffer limit, because I hate loosing stuff because of this
 undo-limit 1000000000 undo-strong-limit 1000000000
 ;; Set the default mode to text-mode
 initial-major-mode (quote text-mode)
 ;; Use shift like everywhere else in org mode
 org-support-shift-select t
 ;; Agenda settings
 org-agenda-files (list "~/txt/org/next.org")
 ;; tag is 4 spaces and not a tab
 tab-with 4 indent-tabs-mode nil
 ;; use native fullscreen on OSX
 ns-use-native-fullscreen t
 ;; Where I keep all my git repos on Linux and OS X
 projectile-project-search-path '("~/Code/")
 ;; Don't create lockfiles, backup files, disable the default autosave crap
 create-lockfiles nil make-backup-files nil auto-save-default nil
 ;; Disable startup message and the "scratch" message.
 inhibit-startup-message t initial-scratch-message nil
 ;; Integrate into the X11 clipboard
 select-enable-clipboard t)
;; Set my font: Source Code Pro.
(set-face-attribute 'default nil 
		    :family "Source Code Pro" 
		    :height 120 
		    :weight 'normal 
		    :width 'normal)
;; Auto load when files change on disk from outside emacs
(global-auto-revert-mode 1)
;; Auto save
(auto-save-visited-mode 1)
;; Dont show scrollbars or those ugly ass icons
(scroll-bar-mode -1)
(tool-bar-mode -1)
;; Ident new lines like the previous
(electric-indent-mode +1)
;; Matching deliminers
(electric-pair-mode 1)
;; Highlight the current line
(global-hl-line-mode 1)
;; Wrap lines
(global-visual-line-mode 1)
;; Pretty symbols
(global-prettify-symbols-mode 1)
;; Show matching parens
(show-paren-mode 1)
;; Bind CxCb to iBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;; C-z are set to work more like most undo systems would
(global-unset-key "\C-z")
(global-set-key "\C-z" 'advertised-undo)
;; Show line numbesr
(global-display-line-numbers-mode +1)
;; Search and highlight something in the current buffer (C-x w)
(global-hi-lock-mode +1)
;; Show Column numbers
(column-number-mode +1)

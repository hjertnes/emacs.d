(setq
 ;; GC
 gc-cons-threshold most-positive-fixnum
 ;; A huge undo buffer limit, because I hate loosing stuff because of this
 undo-limit 1000000000 undo-strong-limit 1000000000
 ;; set the default mode to text-mode
 initial-major-mode (quote text-mode)
 ;; tag is 2 spaces and not a tab
 tab-with 2 indent-tabs-mode nil
 ;; use native fullscreen on OSX
 ns-use-native-fullscreen t
 ;; Where I keep all my git repos on Linux and OS X
 projectile-project-search-path '("~/Code/")
 ;; Don't create lockfiles, backup files, disable the default autosave crap
 create-lockfiles nil make-backup-files nil auto-save-default nil
 ;; Disable startup message and the "scratch" message.
 inhibit-startup-message t initial-scratch-message nil
 ;; Indent of 2 spaces for js
 js-indent-level 2
 ;; Integrate into the X11 clipboard
 ;; don't hide links in org mode
 org-descriptive-links nil select-enable-clipboard t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-hook 'after-init-hook (lambda () 
			     (setq gc-cons-threshold 800000)))
(provide 'pre-setq)

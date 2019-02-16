(setq
 ;; GC
  gc-cons-threshold most-positive-fixnum
  ;; A huge undo buffer limit, because I hate loosing stuff because of this
 undo-limit 1000000000 undo-strong-limit 1000000000
 ;; set the default mode to text-mode
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
 ;; Indent of 2 spaces for js
 js-indent-level 2
 ;; Integrate into the X11 clipboard
 select-enable-clipboard t)
;; reframe
(setq cider-cljs-lein-repl
	"(do (require 'figwheel-sidecar.repl-api)
         (figwheel-sidecar.repl-api/start-figwheel!)
         (figwheel-sidecar.repl-api/cljs-repl))")
(provide 'pre-setq)

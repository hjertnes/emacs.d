;; -*- lexical-binding: t; -*-

;; Raise GC threshold during init for faster startup
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; We call package-initialize manually in init.el
(setq package-enable-at-startup nil)

;; Disable UI elements early to avoid flash
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Copied from the omnisharp github page. Adds support for Csharp auto completion.
;; Details https://github.com/OmniSharp/omnisharp-emacs
;; Arch requires you to install the msbuild-stable package plus dotnet core
;; And you need to have a sln file for your project

;; Set the omnisharp server path manually on windows, because that piece of shit is weird, and only work this way.
(when (is-windows) 
  (setq omnisharp-server-executable-path "C:\\Bin\\omnisharp-roslyn\\OmniSharp.exe"))
(package-install 'omnisharp)
(require 'omnisharp)
(eval-after-load 'company '(add-to-list 'company-backends #'company-omnisharp))

(defun my-csharp-mode-setup () 
  (omnisharp-mode) 
  (company-mode) 
  (flycheck-mode) 
  (setq indent-tabs-mode nil) 
  (setq c-syntactic-indentation t) 
  (c-set-style "ellemtel") 
  (setq c-basic-offset 4) 
  (setq truncate-lines t) 
  (setq tab-width 4) 
  (setq evil-shift-width 4)

					;csharp-mode README.md recommends this too
					;(electric-pair-mode 1)       ;; Emacs 24
					;(electric-pair-local-mode 1) ;; Emacs 25
  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring) 
  (local-set-key (kbd "C-c C-c") 'recompile))

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

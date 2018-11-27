 ; Deft for nvALT stlye notes in Emacs
(use-package 
  deft 
  :ensure t
  :init (setq deft-extensions '("txt" "md" "org") deft-directory "~/txt/notes"
         deft-use-filename-as-title t deft-file-naming-rules '((noslash . "-") 
                                                               (nospace . "-") 
                                                               (case-fn . downcase))))
;; The worlds best Git client
(use-package 
  magit
  :ensure t)
;; File browser app on the left, like Textmate or Sublime.
(use-package 
  neotree
  :ensure t)
;; Used to add history of last used M-x commands into Ivy.
(use-package 
  smex
  :ensure t 
  :config (smex-initialize))
;; Inherit PATh from Shell; but only when not on windows.
(if (is-not-windows) 
    (use-package 
      exec-path-from-shell 
      :ensure t
      :config (exec-path-from-shell-initialize)))
;; Project management
(use-package 
  projectile 
  :ensure t
  :init (setq projectile-indexing-method 'alien projectile-completion-system 'ivy) 
  :config (progn (projectile-mode) 
           (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)))
(require 'ivy)
;; Check syntax on the fly
(use-package 
  flycheck 
  :ensure t
  :config(global-flycheck-mode))
;; Auto completion
(use-package 
  company 
  :ensure t
  :init (setq company-dabbrev-downcase 0 company-idle-delay 0)
  :config (progn(company-mode +1) 
           (global-company-mode +1)))
;; Use Language Server Modules for Programming languages
(use-package 
  lsp-mode 
  :ensure t)
;; Language Server Company Mode Auto Completion
(use-package 
  company-lsp 
  :ensure t
  :config (push 'company-lsp company-backends))
;; Use Ace-jump to move quickly
(use-package 
  ace-jump-mode 
  :ensure t
  :bind (("C-c SPC" . ace-jump-mode) 
         ("C-c C-u SPC" . ace-jump-char-mode) 
         ("C-c C-u C-u SPC" . ace-jump-line-mode)))
;; Disable arrows etc to learn proper emacs movement
(use-package 
  no-easy-keys 
  :ensure t
  :config (no-easy-keys 1))
(require 'ui)
;; Adds support for docker in Tramp
(use-package 
  docker-tramp 
  :ensure t)
;; Docker UI
(use-package 
  docker 
  :ensure t)
;; Stats for load time
(use-package 
  esup 
  :ensure t)
(provide 'core)

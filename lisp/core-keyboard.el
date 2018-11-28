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
(provide 'core-keyboard)

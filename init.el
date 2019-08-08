(when(not(string-equal system-type "windows-nt")) 
  (progn
    (when (not(file-exists-p "~/.emacs.d/personal.el")) 
      (comint-send-string (get-buffer-process (shell)) "touch ~/.emacs.d/personal.el"))

    (when (not(file-exists-p "~/.emacs.d/custom.el")) 
      (comint-send-string (get-buffer-process (shell)) "touch ~/.emacs.d/custom.el"))))

(require 'org)
(org-babel-load-file "~/.emacs.d/hjertnes.org")

(load "~/.emacs.d/personal.el")
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

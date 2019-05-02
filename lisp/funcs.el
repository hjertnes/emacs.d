;; Create new blank buffer. Stolen from; http://ergoemacs.org/emacs/emacs_new_empty_buffer.html
(defun new-empty-buffer () 
  "Create a new empty buffer." 
  (interactive) 
  (let (($buf (generate-new-buffer "untitled"))) 
    (switch-to-buffer $buf) 
    (funcall initial-major-mode) 
    (setq buffer-offer-save t)
    $buf))
;; Check if current system is windows
(defun is-windows () 
  (interactive) 
  (eq system-type 'windows-nt))
;; Check if current system is not windows
(defun is-not-windows () 
  (interactive) 
  (not (eq system-type 'windows-nt)))
(defun is-mac () 
  (interactive) 
  (eq system-type 'darwin))
(defun is-linux () 
  (interactive) 
  (eq system-type 'gnu/linux))
(defun save-all () (interactive) (save-some-buffers t))
(provide 'funcs)


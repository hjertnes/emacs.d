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
  (not (eq system-type 'windows-nt)))
;; Check if current system is not windows
(defun is-not-windows () 
  (not(is-not-windows)))

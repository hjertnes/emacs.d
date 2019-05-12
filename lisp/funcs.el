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
(defun save-all () 
  (interactive) 
  (save-some-buffers t))
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y" 
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")



(defun insert-datetime () 
  (interactive) 
  (insert (concat (format-time-string "%Y-%m-%dT%T") 
		  ((lambda 
		     (x) 
		     (concat (substring x 0 3) ":" (substring x 3 5))) 
		   (format-time-string "%z")))))

(defun newline2() (insert "\n"))
(defun new-post ()
  (interactive)
  (insert ":PROPERTIES:")
  (newline2)
  (insert ":EXPORT_HUGO_CUSTOM_FRONT_MATTER: :type post")
  (newline2)
  (insert (concat ":EXPORT_HUGO_CUSTOM_FRONT_MATTER+: :url " (format-time-string "/%Y/%m/%d/")))
  (newline2)
  (insert (concat ":EXPORT_HUGO_CUSTOM_FRONT_MATTER+: :date " (format-time-string "%Y-%m-%dT%T") 
		  ((lambda 
		     (x) 
		     (concat (substring x 0 3) ":" (substring x 3 5))) 
		   (format-time-string "%z"))))
  (newline2)
  (insert (concat ":EXPORT_FILE_NAME: " (format-time-string "%Y-%m-%d-")))
  (newline2)
  (insert ":END:")
  (newline2))






(provide 'funcs)

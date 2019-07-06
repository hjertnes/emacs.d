(require 'request)

(defun get-password (name) 
  (let* ((results (auth-source-search :host name)) 
	 (result (car results)) 
	 (secrets (plist-get result 
			     :secret)) 
	 (secret (first (aref (aref secrets 2) 0)))) secret))  

(defun microblog () 
  "Post without title." 
  (interactive) 
  (if (yes-or-no-p "Are you sure you want to post this? ")
      (progn
      (switch-to-buffer (org-md-export-as-markdown))
      (request "https://micro.blog/micropub" 
	       :type "POST" 
	       :data `(("h"."entry")
		       ("content" .
			,(buffer-substring-no-properties 
			  (point-min) 
			  (point-max))))
	       :headers `(("Authorization" . ,(format "Bearer %s" (get-password "microblog"))))
	       :success (cl-function (lambda 
				       (&key 
					data
					&allow-other-keys)
				       (message "Success")))))))
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

(defun get-url()
  (format-time-string "/%Y/%m/%d/"))
(defun get-datestring()
  (format-time-string "%Y-%m-%dT%T"))
(defun get-timestring()
  ((lambda (x) 
		     (concat (substring x 0 3) ":" (substring x 3 5))) 
		   (format-time-string "%z")))


(defun get-timezone() (format-time-string "%z"))
(defun insert-datetime () 
  (interactive) 
  (insert (concat (format-time-string "%Y-%m-%dT%T") 
		  ((lambda (x) 
		     (concat (substring x 0 3) ":" (substring x 3 5))) 
		   (format-time-string "%z")))))
(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))
(provide 'funcs)

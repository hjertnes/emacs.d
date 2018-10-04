(use-package 
  org  
  :ensure t 
  :init (setq org-support-shift-select t org-agenda-files (list "~/txt/org/next.org")))
(use-package 
  org-bullets  
  :ensure t 
  :config (add-hook 'org-mode-hook 
		    (lambda () 
		      (org-bullets-mode 1))))
(defun org-archive-done-tasks () 
  (interactive) 
  (org-map-entries 
   (lambda () 
     (org-archive-subtree) 
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))

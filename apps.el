
(use-package 
	deft 
  :ensure t 
  :init (setq deft-extensions '("txt" "md" "org") deft-directory "~/txt/notes"
			  deft-use-filename-as-title t deft-file-naming-rules '((noslash . "-") 
																	(nospace . "-") 
																	(case-fn . downcase))))
(use-package 
	magit 
  :ensure t)

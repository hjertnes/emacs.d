
(use-package 
  deft 
  :ensure t 
  :defer 2 
  :init (setq deft-extensions '("txt" "md" "org") deft-directory "~/txt/notes"
	      deft-use-filename-as-title t deft-file-naming-rules '((noslash . "-") 
								    (nospace . "-") 
								    (case-fn . downcase))))
(use-package 
  magit 
  :defer 2 
  :ensure t)

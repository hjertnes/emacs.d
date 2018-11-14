;; Deft for nvALT stlye notes in Emacs
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

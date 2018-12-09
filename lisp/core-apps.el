;; Docker UI
(use-package 
  docker 
  :ensure t)
 ; Deft for nvALT stlye notes in Emacs
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
(provide 'core-apps)
;; Hugo Apps
(use-package easy-hugo :ensure t
:init
(progn
(setq easy-hugo-basedir "~/Code/hugo-hjertnes/"
easy-hugo-url "https://hjertnes.blog"
easy-hugo-previewtime "300"
easy-hugo-bloglist
	'(((easy-hugo-basedir . "~/Code/hugo-inksmudge/")
	(easy-hugo-url . "http://inksmudge.net")))))

:bind ("C-c C-e" . easy-hugo))

;; Auto load when files change on disk from outside emacs
(global-auto-revert-mode +1)
;; Auto save
(auto-save-visited-mode +1)
;; Dont show scrollbars or those ugly ass icons
(scroll-bar-mode -1)
(tool-bar-mode -1)
;; Ident new lines like the previous
(electric-indent-mode +1)
;; Matching deliminers
(electric-pair-mode +1)
;; linum
(global-linum-mode 1)
;; Highlight the current line
(global-hl-line-mode 1)
;; divider
(window-divider-mode 1)
;; Wrap lines
(global-visual-line-mode 1)
;; Show matching parens
(show-paren-mode 1)
;; Search and highlight something in the current buffer (C-x w)
(global-hi-lock-mode +1)
;; Show Column numbers
(column-number-mode +1)
;; Server mode (enables emacsclient)
(server-mode +1)
(provide 'pre-modes)

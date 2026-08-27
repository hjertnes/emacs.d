;; -*- lexical-binding: t; -*-

;; Raise GC threshold during init for faster startup
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; We call package-initialize manually in init.el
(setq package-enable-at-startup nil)

;; Keep installed packages out of this iCloud-synced tree, matching backups
;; (~/.emacs-backups/), auto-saves (~/.emacs-autosave/), undo history and the
;; eln-cache below. The package directory doubles as the config's de-facto
;; version snapshot (see "Version pinning policy" in hjertnes.org), so it
;; especially must not live where iCloud can evict or conflict-copy it.
(setq package-user-dir (expand-file-name "~/.emacs-packages/"))

;; Package state that defaults to ~/.emacs.d/<dir>/ goes to ~/.emacs-state/:
;; transient's persisted levels/values/history and emojify's downloaded images.
;; Set here, before any package loads, so the defaults never materialise
;; inside the synced tree.
(setq transient-levels-file (expand-file-name "~/.emacs-state/transient/levels.el")
      transient-values-file (expand-file-name "~/.emacs-state/transient/values.el")
      transient-history-file (expand-file-name "~/.emacs-state/transient/history.el")
      emojify-emojis-dir (expand-file-name "~/.emacs-state/emojis/"))

;; Keep the native-compilation cache out of this iCloud-synced tree.
;; Redirect it to a local, unsynced directory (same idea as ~/.emacs-backups/).
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename (expand-file-name "~/.emacs-eln-cache/"))))

;; Disable UI elements early to avoid flash
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

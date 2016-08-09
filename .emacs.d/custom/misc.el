;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
;; No splash screen, no initial scratch text
;; and plump for org-mode as initial major mode
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

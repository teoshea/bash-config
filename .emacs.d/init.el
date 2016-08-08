;; No splash screen, no initial scratch text
;; and plump for org-mode as initial major mode
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Turn off the scroll bar, tool bar and menu
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Typing over selected text deletes whole selected block
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; http://aaronbedra.com/emacs.d
;; Empty line marker on left hand side
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;;; STEP 1 - Extra key bindings
;(global-set-key "\M-C" 'compile)
;(global-set-key "\C-^" 'next-error)
;(global-set-key "\C-\M-g" 'goto-line)
(global-set-key "\C-\M-c" (lambda() (interactive)(find-file "~/.emacs")))
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)

;;; STEP 2 - Directory settings and general defaults
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms  `((".*" ,temporary-file-directory t)))
(set-default-font "Consolas 12")
(setq delete-by-moving-to-trash t)
;; Don't show startup screen
(setq inhibit-startup-screen t)
;; Font locking
(global-font-lock-mode 1)
;; Maximum colors
(setq font-lock-maximum-decoration 3)
;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)

;;; STEP 3 - Package management
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)


;; Install a basic set of starter-kit packages
(defvar my-packages '(haskell-mode
                      auto-complete
                      color-theme
		      starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      bash-completion
                      recentf
                      vlf))

(dolist (p my-packages)
   (when (not (package-installed-p p))
      (package-install p)))


;;; STEP 4 -  PACKAGES SETUP

;;  Color Theme
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-billw)

;;  Recentf
(recentf-mode 1)

;; Auto Complete
(ac-config-default)

;; Haskell Mode
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hic?$"   . haskell-mode)
                ("\\.hsc$"    . haskell-mode)
                ("\\.chs$"    . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)

;adding the following lines according to which modules you want to use:
(require 'inf-haskell)

(add-hook 'haskell-mode-hook 'turn-on-font-lock)
;(add-hook 'haskell-mode-hook 'turn-off-haskell-decl-scan)
;(add-hook 'haskell-mode-hook 'turn-off-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 
   (function
    (lambda ()
      (setq haskell-program-name "ghci")
      (setq haskell-ghci-program-name "ghci6"))))

;;; STEP 3.2.2 - Bash Completion
;;(require 'bash-completion)
;;(bash-completion-setup)


;;; STEP 3.2.4 - Haskell Mode
;(require 'haskell-mode)

;;;; Add Cabal Repository to Emacs 
;(let ((my-cabal-path (concat (getenv "USERPROFILE") "\\AppData\\Roaming\\cabal\\bin")))
;  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
;  (add-to-list 'exec-path my-cabal-path))
;(custom-set-variables '(haskell-tags-on-save t))
;
;(setq auto-mode-alist
;   (append auto-mode-alist
;      '(("\\.[hg]s$"  . haskell-mode)
;        ("\\.hic?$"   . haskell-mode)
;        ("\\.hsc$"    . haskell-mode)
;        ("\\.chs$"    . haskell-mode)
;       ("\\.l[hg]s$" . literate-haskell-mode))))

;(autoload 'haskell-mode "haskell-mode"  "Major mode for editing Haskell scripts." t)
;(autoload 'literate-haskell-mode "haskell-mode"  "Major mode for editing literate Haskell scripts." t)

;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; Haskell Mode keybindings

;(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
;(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
;(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
;(define-key haskell-mode-map [f8] 'haskell-navigate-imports)

;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(tool-bar-mode nil))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )

;; ;; load haskell-mode
;; (load "~/lib/emacs/haskell-mode/haskell-site-file")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;; ;adding the following lines according to which modules you want to use:
;; (require 'inf-haskell)

;; (add-hook 'haskell-mode-hook 'turn-on-font-lock)
;; ;;(add-hook 'haskell-mode-hook 'turn-off-haskell-decl-scan)
;; ;;(add-hook 'haskell-mode-hook 'turn-off-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
;; (add-hook 'haskell-mode-hook 
;;    (function
;;     (lambda ()
;;       (setq haskell-program-name "~/ghci.bat"))))

; Use git bash for shell
;(if (equal system-type 'windows-nt)
;    (progn (setq explicit-shell-file-name "C:/Program Files (x86)/Git/bin/sh.exe")
;           (setq shell-file-name "bash")
;           (setq explicit-sh.exe-args '("--login" "-i"))
;           (setenv "SHELL" shell-file-name)
;           (add-hook 'comint-output-filter-functions
;                     'comint-strip-ctrl-m)))

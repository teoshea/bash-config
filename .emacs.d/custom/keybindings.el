;;; keybindings.el --- A collection of useful key bindings
;;; Commentary:
;; I find it useful to have all these in one place

;;; Code:
;; Use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "s-k") 'kill-this-buffer)
(global-set-key (kbd "s-l") 'eval-buffer)

(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

(global-set-key (kbd "RET") 'newline-and-indent)

(keypad-setup 'numeric)
(global-set-key (kbd "s-<kp-1>") 'delete-other-windows)
(global-set-key (kbd "s-<kp-end>") 'delete-other-windows)
(global-set-key (kbd "s-<kp-2>") 'split-window-below)
(global-set-key (kbd "s-<kp-down>") 'split-window-below)
(global-set-key (kbd "s-<kp-next>")     'split-window-right)

(global-set-key (kbd "s-=") 'default-text-scale-increase)
(global-set-key (kbd "s-+") 'default-text-scale-increase)
(global-set-key (kbd "s--") 'default-text-scale-decrease)
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
(global-set-key (kbd "<C-s-mouse-4>") 'enlarge-window)
(global-set-key (kbd "<C-s-mouse-5>") 'shrink-window)

(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status-internal)

(global-set-key (kbd "s-q") 'mu4e)

(provide 'keybindings)
;;; keybindings.el ends here

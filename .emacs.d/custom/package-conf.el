;;; package-conf.el -- Configure my packages in the way I'd like

;;; Commentary:

;;; Code:

(require 'use-package)

(use-package php-mode
  :ensure t
  :mode "\\.php[345]?\\'"
  :config (add-hook 'php-mode-hook 'php-mode-init))

;; web-mode
;; http://web-mode.org
;; (use-package web-mode
;;   :mode (("\\.html\\'" . web-mode)
;;          ;("\\.tmpl\\'" . web-mode)
;;          ;("\\.twig\\'" . web-mode)
;;          ;("\\.hbs\\'" . web-mode)
;;          ;("\\.handlebars\\'" . web-mode)
;;          )
;;   :config
;; (add-hook 'web-mode-hook 'web-mode-init))

(defun php-mode-init ()
  "My php-mode config."

  (auto-complete-mode t)
  (require 'ac-php)
  (setq ac-sources  '(ac-source-php ) )
  (yas-global-mode 1)
  (define-key php-mode-map (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
  (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
)

(defun web-mode-init ()
  "My web-mode config."

  ;; web-mode specific config, to make indentation and comments behave the way
  ;; I expect.
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-indent-style 2)
  (setq web-mode-comment-style 2)

  (setq web-mode-style-padding 0)
  (setq web-mode-script-padding 0)
  (setq web-mode-block-padding 0)

  (setq web-mode-ac-sources-alist
        '(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
          ("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
          ("javascript" . (ac-source-yasnippet))
          ("css" . (ac-source-css-property
                    ac-source-css-property-names
                    ac-source-emmet-css-snippets))))

  )


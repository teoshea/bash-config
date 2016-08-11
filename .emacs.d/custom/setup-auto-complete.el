(require 'auto-complete-config)
(ac-config-default)

(require 'yasnippet)
(yas-global-mode 1)

(require 'php-auto-yasnippets)
(require 'emmet-mode)
(require 'ac-emmet)

(add-to-list 'ac-modes 'web-mode)

;; Extend Autocomplete web-mode
(setq web-mode-ac-sources-alist
      '(("php" . (  ac-source-php-auto-yasnippets
                    ac-source-yasnippet
                    ac-source-abbrev
                    ac-source-gtags
                    ac-source-semantic
                    ac-source-dictionary
                    ac-source-words-in-same-mode-buffers
                    ac-source-words-in-buffer
                    ac-source-files-in-current-dir
        ))
        ("html" . ( ac-source-emmet-html-aliases 
                    ac-source-emmet-html-snippets
                    ac-source-yasnippet
                    ac-source-abbrev
                    ac-source-gtags
                    ac-source-semantic
                    ac-source-dictionary
                    ac-source-words-in-same-mode-buffers
                    ac-source-words-in-buffer
                    ac-source-files-in-current-dir
                  ))
        ("css" . (  ac-source-css-property 
                    ac-source-emmet-css-snippets
                    ac-source-yasnippet
                    ac-source-abbrev
                    ac-source-gtags
                    ac-source-semantic
                    ac-source-dictionary
                    ac-source-words-in-same-mode-buffers
                    ac-source-words-in-buffer
                    ac-source-files-in-current-dir
                  ))
        )
)

(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
                   (yas-activate-extra-mode 'php-mode)
                 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                 (setq emmet-use-css-transform nil))
               )
             )
          )

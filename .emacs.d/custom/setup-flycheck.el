(add-hook 'after-init-hook #'global-flycheck-mode)

(setq-default flycheck-disabled-checkers '(php/php-phpmd))

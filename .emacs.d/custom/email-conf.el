(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'smtpmail)

;; Cambridge
(setq mu4e-maildir (expand-file-name "~/.Maildir"))
(setq user-full-name "Tom O'Shea")

(setq mu4e-headers-fields
      '((:human-date . 11)
        (:flags . 5)
        (:mailing-list . 13)
        (:from-or-to . 20)
        (:from . 20)
        (:subject)))

(setq mu4e-sent-folder "/hermes/Sent")
(setq mu4e-drafts-folder "/hermes/Drafts")
(setq mu4e-trash-folder "/hermes/Trash")
(setq mu4e-refile-folder "/hermes/Archive")

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-debug-info t)

(setq message-citation-line-function 'message-insert-formatted-citation-line)
(setq message-citation-line-format "\nOn %a, %b %d %Y at %H:%m, %f wrote:")

(defvar my-mu4e-account-alist
  '(("hermes"
     (user-mail-address "teo26@cam.ac.uk")
     (mu4e-reply-to-address "teo26@cam.ac.uk")
     (mu4e-user-mail-address-list ("teo26@cam.ac.uk" "teo26@maths.cam.ac.uk"))
     (mu4e-sent-folder "/hermes/Sent")
     (mu4e-drafts-folder "/hermes/Drafts")
     (mu4e-trash-folder "/hermes/Trash")
     (mu4e-refile-folder "/hermes/Archive")
     (mu4e-sent-messages-behavior sent)
     (smtpmail-smtp-server "smtp.hermes.cam.ac.uk")
     (smtpmail-default-smtp-server "smtp.hermes.cam.ac.uk")
     (smtpmail-starttls-credentials '(("smtp.hermes.cam.ac.uk" 587 nil nil)))
     (smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg"))
     (smtpmail-smtp-service 587)
     (message-signature t)
     (message-signature-file "~/.hermes-signature")
     )
    ("gmail"
     (user-mail-address "osheate@gmail.com")
     (user-reply-to-address "osheate@gmail.com")
     (mu4e-user-mail-address-list ("osheate@gmail.com"))
     (mu4e-sent-folder "/gmail/Sent Mail")
     (mu4e-drafts-folder "/gmail/Drafts")
     (mu4e-trash-folder "/gmail/Trash")
     (mu4e-refile-folder "/gmail/All Mail")
     ; ;don't save message to Sent Messages, GMail/IMAP will take care of this
     (mu4e-sent-messages-behavior lambda ()
                                  ('delete))
     
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-starttls-credentials '(("smtp.hermes.cam.ac.uk" 587 nil nil)))
     (smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg"))
     (smtpmail-smtp-service 587)
     (message-signature nil)
     )))

(setq mu4e-user-mail-address-list
      (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
              my-mu4e-account-alist))

;;setup some handy shortcuts
(setq mu4e-maildir-shortcuts
      '(("/hermes/INBOX"    . ?i)
        ("/hermes/Drafts"   . ?d)
        ("/hermes/Archive"  . ?a)
        ("/hermes/Sent"     . ?s)
        ("/hermes/Trash"    . ?t)))

(setq mu4e-bookmarks
      '(("maildir:/hermes/INBOX" "Hermes Inbox" ?i)
        ("maildir:/hermes/Drafts" "Hermes Drafts" ?d)
        ("maildir:/hermes/Archive" "Hermes Archive" ?a)
        ("maildir:/hermes/Sent" "Hermes Sent" ?s)
        ("maildir:/hermes/Trash" "Hermes Trash" ?t)
        ("maildir:\"/gmail/[Google Mail].All Mail\" AND tag:\\\\Inbox" "Gmail Inbox" ?I)
        ("maildir:\"/gmail/[Google Mail].All Mail\" AND tag:\\\\Drafts" "Gmail Drafts" ?D)
        ("maildir:\"/gmail/[Google Mail].All Mail\" AND tag:\\\\Sent" "Gmail Sent" ?S)
        ("maildir:\"/gmail/[Google Mail].All Mail\" AND NOT tag:\\\\Inbox" "Gmail Archive" ?A)))

(setq mu4e-attachment-dir  "~/Downloads")

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "mbsync hermes")

;; update every 10 mins
(setq mu4e-update-interval 600)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq mu4e-change-filenames-when-moving t)

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(defun extract-account-name-from-maildir-search (arg)
   (when (string-match "maildir:\"/\\(\\w+\\)/.*\"$" arg)
      (let* ((temp (match-string 1 arg))
            (account-vars (cdr (assoc temp my-mu4e-account-alist))))
        (if account-vars
            (mapc #'(lambda (var)
                      (set (car var) (cadr var)))
                  account-vars)
          (error "No email account found")))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
(add-hook 'mu4e-headers-search-hook 'extract-account-name-from-maildir-search)
(add-hook 'mu4e-compose-mode-hook
          (defun do-compose-activities ()
            "Personal settings for message composition."
            (flyspell-mode)))

;; add tags
(setq mu4e-action-tags-header "X-Keywords")
(add-to-list 'mu4e-headers-actions '("tRetag message" . mu4e-action-retag-message) t)
(add-to-list 'mu4e-view-actions '("tRetag message" . mu4e-action-retag-message) t)



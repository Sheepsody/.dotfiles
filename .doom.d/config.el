;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal information
(setq user-full-name "Victor Vialard"
      user-mail-address "vvialard@hotmail.fr")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Auto-completion configuration

(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.


;; Relative numbers by default

(setq display-line-numbers-type 'relative)

;; Org Configuration


(after! org
  (setq org-directory (expand-file-name "~/Dropbox/Org/"))
  (setq org-default-notes-file (concat org-directory "inbox.org"))
  (setq org-agenda-files '("~/Dropbox/Org/inbox.org"
                           "~/Dropbox/Org/tickler.org"
                           "~/Dropbox/Org/gtd.org"))
  (setq org-archive-location (concat org-directory "archived.org::"))
  (setq org-capture-templates
        '(("t" "Todo [inbox]" entry
           (file+headline "~/Dropbox/Org/inbox.org" "Tasks")
           "* TODO %i%?")
          ("T" "Tickler" entry
           (file+headline "~/Dropbox/Org/tickler.org" "Tickler")
           "* %i%? \n %U")))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-todo-keyword-faces
        '(("TODO"  :foreground "#ffcb6b" :weight normal :underline t)
          ("NEXT" :foreground "#40E0D0" :weight normal :underline t)
          ("WAITING" :foreground "#b2ccd6" :weight normal :underline t)
          ("DONE" :foreground "#c3e88d" :weight normal :underline t)
          ("CANCELLED" :foreground "#ff5370" :weight normal :underline t))))

;; Rust configutation

(setq lsp-rust-server 'rust-analyzer)

;; Js/Ts/CSS config

(use-package prettier-js
  :ensure t
  :config
  (setq prettier-js-args '(
                           "--trailing-comma" "es5"
                           "--single-quote" "true"
                           "--print-width" "120"
                           "--tab-width" "4"
                           "--use-tabs" "false"
                           "--jsx-bracket-same-line" "false"
                           "--stylelint-integration" "true"
                           )))

(use-package js2-mode
  :ensure t)

(use-package rjsx-mode
  :ensure t
  :mode(("\\.js\\'" . rjsx-mode)
        ("\\.jsx\\'" . rjsx-mode))
  :init
  (add-hook 'rjsx-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'tide-mode))

(use-package tide
  :ensure t
  :mode(("\\.ts\\'" . typescript-mode))
  :init
  (add-hook 'typescript-mode-hook 'tide-mode)
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  :config
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save-mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; Org Super Agenda & Custom views

(use-package! org-super-agenda
  :commands (org-super-agenda-mode))

(after! org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-day nil ;; i.e. today
        org-agenda-span 1
        org-agenda-start-on-weekday nil)

  (setq org-agenda-custom-commands
        '(("z" "Custom GTD view"
           ((agenda "" ((org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t
                            :date today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Next to do"
                             :todo "NEXT"
                             :order 1)
                            (:name "Important"
                             :tag "Important"
                             :priority "A"
                             :order 6)
                            (:name "Due Today"
                             :deadline today
                             :order 2)
                            (:name "Due Soon"
                             :deadline future
                             :order 8)
                            (:name "Overdue"
                             :deadline past
                             :order 7)
                            (:name "To read"
                             :tag "read"
                             :order 10)
                            (:name "To do"
                             :todo "TODO"
                             :order 20)
                            (:name "Waiting"
                             :todo "WAITING"
                             :order 30)
                            ))))))))
  :config
  (org-super-agenda-mode))

;; Open org files on startup

(add-hook 'emacs-startup-hook
          (lambda ()
            (find-file "~/Dropbox/Org/someday.org")
            (org-agenda nil "z")
            (split-window-horizontally)
            (find-file-other-window (concat org-directory "inbox.org"))
            (split-window-vertically)
            (find-file-other-window (concat org-directory "gtd.org"))))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal information
(setq user-full-name "Victor Vialard"
      user-mail-address "vvialard@hotmail.fr")

;; Doom's theme
(setq doom-theme 'doom-one)

;; Start a good morning...
(setq fancy-splash-image "~/.doom.d/totoro.png")

;; Display time & Org Clock config
(display-time-mode 1)
(setq org-global-properties
      '(("Effort_ALL" .
         "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")))

;; Auto-completion configuration

(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

;; Language config

(setq ispell-dictionary "en_GB")

;; Relative numbers by default

(setq display-line-numbers-type 'relative)

;; Org Configuration

(setq org-directory (expand-file-name "~/Dropbox/Org/"))
(setq org-roam-directory "~/Dropbox/Roam/")
(setq org-image-actual-width '(600))

(after! org
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

(add-hook 'org-mode-hook (lambda ()
                           (setq-local time-stamp-active t
                                       time-stamp-line-limit 18
                                       time-stamp-start "^#\\+hugo_lastmod: [ \t]*"
                                       time-stamp-end "$"
                                       time-stamp-format "\[%Y-%m-%d %a %H:%M:%S\]")
                           (add-hook 'before-save-hook 'time-stamp nil 'local)))

;; Rust configutation

(setq lsp-rust-server 'rust-analyzer)

;; Js/Ts/CSS config

(use-package prettier-js
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

(use-package js2-mode)

(use-package rjsx-mode
  :mode(("\\.js\\'" . rjsx-mode)
        ("\\.jsx\\'" . rjsx-mode))
  :init
  (add-hook 'rjsx-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'tide-mode))

(use-package tide
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
                            :discard (:tag "daily")
                            :time-grid t
                            :date today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '(
                            (:name "Dailies"
                             :and (:tag "daily"
                                   :not (:scheduled future))
                             :order 9)
                            (:discard (:tag "daily"))
                            (:name "Immediatly"
                             :and (:priority "A" :todo "NEXT")
                             :order 1)
                            (:name "Next to do"
                             :todo "NEXT"
                             :order 2)
                            (:name "Due Today"
                             :deadline today
                             :order 3)
                            (:name "Important"
                             :tag "Important"
                             :priority "A"
                             :order 4)
                            (:name "Overdue"
                             :deadline past
                             :order 5)
                            (:name "Due Soon"
                             :deadline future
                             :order 6)
                            (:name "Less important"
                             :priority "B"
                             :order 7)
                            (:name "Trivial"
                             :tag "trivial"
                             :priority<= "C"
                             :order 30)
                            (:name "Courses"
                             :tag "course"
                             :order 11)
                            (:name "To read"
                             :tag "read"
                             :order 12)
                            (:name "Shopping"
                             :tag "shop"
                             :order 13)
                            (:name "Courses"
                             :tag "course"
                             :order 14)
                            (:name "To do"
                             :todo "TODO"
                             :order 20)
                            (:name "Waiting"
                             :todo "WAITING"
                             :order 25)
                            ))))))))
  :config
  (org-super-agenda-mode))

;; Open org files on startup

;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (org-agenda nil "z")
;;             (split-window-horizontally)
;;             (find-file-other-window (concat org-directory "inbox.org"))
;;             (split-window-vertically)
;;             (find-file-other-window (concat org-directory "gtd.org"))))
;; Python Environnements

(use-package pyvenv
  :config
  (pyvenv-mode t)
  (setenv "WORKON_HOME" "~/.pyenv/versions")

  ;; Set correct Python interpreter
  (setq pyvenv-post-activate-hooks
        #'(lambda ()
            (call-interactively #'lsp-workspace-restart)
            (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python3"))))
  (setq pyvenv-post-deactivate-hooks
        (list (lambda ()
                (setq python-shell-interpreter "python3")))))

(setq org-html-head "<link rel=\"stylesheet\" href=\"https://rawgithub.com/edwardtufte/tufte-css/gh-pages/tufte.css\" type=\"text/css\" />")

;; C++ Config
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; Org Roam Server

(use-package org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; Org Roam
;; From https://github.com/alexkehayias/emacs.d/

(setq org-roam-publish-path "~/GitHub/MySecondBrainWebsite")
(setq org-roam-notes-path "~/Dropbox/Roam")

(use-package org-roam
  :config
  (setq org-roam-graph-executable "neato")
  (setq org-roam-graph-extra-config
        '(("overlap" . "false")))
  :init
  ;; These functions need to be in :init otherwise they will not be
  ;; callable in an emacs --batch context which for some reason
  ;; can't be found in autoloads if it's under :config
  (defun my/org-roam--extract-note-body (file)
    (with-temp-buffer
      (insert-file-contents file)
      (org-mode)
      (first (org-element-map (org-element-parse-buffer) 'paragraph
               (lambda (paragraph)
                 (let ((begin (plist-get (first (cdr paragraph)) :begin))
                       (end (plist-get (first (cdr paragraph)) :end)))
                   (buffer-substring begin end)))))))

  ;; Include backlinks in org exported notes not tagged as private or
  ;; draft
  (defun my/org-roam--backlinks-list (file)
    (if (org-roam--org-roam-file-p file)
        (--reduce-from
         (concat acc (format "- [[file:%s][%s]]\n"
                             (file-relative-name (car it) org-roam-directory)
                             (org-roam-db--get-title (car it))))
         ""
         (org-roam-db-query
          [:select :distinct [links:source]
           :from links
           :left :outer :join tags :on (= links:source tags:file)
           :where (and (= dest $s1)
                       (or (is tags:tags nil)
                           (and
                            (not-like tags:tags '%private%)
                            (not-like tags:tags '%draft%))))]
          file))
      ""))

  (defun file-path-to-md-file-name (path)
    (let ((file-name (first (last (split-string path "/")))))
      (concat (first (split-string file-name "\\.")) ".md")))

  ;; Fetches all org-roam files and exports to hugo markdown
  ;; files. Adds in necessary hugo properties
  ;; e.g. HUGO_BASE_DIR. Ignores notes tagged as private or draft
  (defun org-roam-to-hugo-md ()
    (interactive)
    ;; Make sure the author is set
    (setq user-full-name "Victor Vialard")

    (let ((files (mapcan
                  (lambda (x) x)
                  (org-roam-db-query
                   [:select [files:file]
                    :from files
                    :left :outer :join tags :on (= files:file tags:file)
                    :where (or (is tags:tags nil)
                               (and
                                (not-like tags:tags '%private%)
                                (not-like tags:tags '%draft%)))]))))
      (mapc
       (lambda (f)
         ;; Use temporary buffer to prevent a buffer being opened for
         ;; each note file.
         (with-temp-buffer
           (message "Working on: %s" f)
           (insert-file-contents f)

           (goto-char (point-min))
           ;; Add in hugo tags for export. This lets you write the
           ;; notes without littering HUGO_* tags everywhere
           ;; HACK:
           ;; org-export-output-file-name doesn't play nicely with
           ;; temp buffers since it attempts to get the file name from
           ;; the buffer. Instead we explicitely add the name of the
           ;; exported .md file otherwise you would get prompted for
           ;; the output file name on every note.
           (insert
            (format "#+HUGO_BASE_DIR: %s\n#+HUGO_SECTION: posts\n#+EXPORT_FILE_NAME: %s\n"
                    org-roam-publish-path
                    (file-path-to-md-file-name f)))

           ;; If this is a placeholder note (no content in the
           ;; body) then add default text. This makes it look ok when
           ;; showing note previews in the index and avoids a headline
           ;; followed by a headline in the note detail page.
           (if (eq (my/org-roam--extract-note-body f) nil)
               (progn
                 (goto-char (point-max))
                 (insert "\n/This note does not have a description yet./\n")))

           ;; Add in backlinks because
           ;; org-export-before-processing-hook won't be useful the
           ;; way we are using a temp buffer
           (let ((links (my/org-roam--backlinks-list f)))
             (unless (string= links "")
               (goto-char (point-max))
               (insert (concat "\n* Links to this note\n") links)))

           (org-hugo-export-to-md)))
       files)))

  (map! :leader
        :desc "Export Roam notes with Ox-Hugo"
        "n r h" #'org-roam-to-hugo-md)
  :config
  (setq org-roam-capture-templates
        '(("p" "private" plain #'org-roam--capture-get-point "%?"
           :file-name "%<%Y%m%d%H%M%S>-${slug}"
           :head "#+TITLE: ${title}\n#+date: %t\n#+hugo_lastmod: %t\n#+ROAM_TAGS: private\n\n"
           :unnarrowed t)
          ("d" "draft" plain #'org-roam--capture-get-point "%?"
           :file-name "%<%Y%m%d%H%M%S>-${slug}"
           :head "#+TITLE: ${title}\n#+date: %t\n#+hugo_lastmod: %t\n#+ROAM_TAGS: draft\n\n"
           :unnarrowed t))))

(use-package ox-hugo
  :config
  (setq org-hugo-date-format "%Y-%m-%d"))

(use-package citeproc-org
  :ensure t
  :after ox-hugo
  :config
  (citeproc-org-setup))

;; Deft Configuration

(use-package deft
  :config
  (setq deft-extensions '("txt" "tex" "org"))
  (setq deft-directory "~/Dropbox/Roam")
  (setq deft-recursive t))

;; Org Roam Bibtex

(use-package org-ref
  :after org
  :config
  (setq org-ref-bibliography-notes "~/Dropbox/Roam/notes/"
        org-ref-default-bibliography '("~/Dropbox/Roam/references.bib")
        org-ref-pdf-directory "~/Dropbox/Roam/pdf/"))

(after! org-ref
  (setq bibtex-completion-pdf-symbol "⌘")
  (setq bibtex-completion-notes-symbol "✎")
  (setq bibtex-completion-bibliography "~/Dropbox/Roam/references.bib")
  (setq bibtex-completion-library-path "~/Dropbox/Roam/pdf/")
  (setq bibtex-completion-notes-path "~/Dropbox/Roam/notes/"))

;; Journal

(use-package! org-journal
  :ensure t
  :defer t
  :config
  (setq org-journal-dir "~/Dropbox/Journal/"
        org-journal-file-type 'weekly
        org-journal-date-prefix "* "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%A, %B %d %Y"
        org-journal-file-header "#+TITLE: Weekly Journal\n#+SUBTITLE: Week %U, %B %Y\n#+STARTUP: folded\n\n")
  (defun org-journal-find-location ()
    (org-journal-new-entry t)
    (unless (eq org-journal-file-type 'daily)
      (org-narrow-to-subtree))
    (goto-char (point-max)))
  (add-to-list 'org-capture-templates
               `("j" "Journal entry" entry (function org-journal-find-location)
                 "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
                 :jump-to-captured t :immediate-finish t))
  (add-to-list 'org-capture-templates
               `("w" "Weekly review" entry (function org-journal-find-location)
                 (file ,(expand-file-name "~/Dropbox/Org/weekly.org"))
                 :jump-to-captured t :immediate-finish t)))

;; ElFeed RSS reader

(use-package! elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Dropbox/Org/elfeed.org")))
(map! :leader
      (:prefix-map ("e" . "elfeed")
       :desc "ElFeed" "e" #'elfeed))

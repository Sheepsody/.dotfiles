;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Js/Ts/Css/Web packages

(package! prettier-js)

;; Python editing

(package! numpydoc)

;; Org Mode extensions

(package! org-super-agenda)
(package! org-ref)
(package! citeproc-org)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-roam-ui
  :recipe (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out")))

(package! org-clock-csv)
(package! org-gcal)

(package! elfeed-org)
(package! elfeed-summary)

(package! org-download)

;; Fix issue Magit
(package! gitconfig-mode
  :recipe (:host github :repo "magit/git-modes"
           :files ("gitconfig-mode.el")))
(package! gitignore-mode
  :recipe (:host github :repo "magit/git-modes"
           :files ("gitignore-mode.el")))
(package! git-gutter)

(package! dwim-shell-command)
(package! map)
(package! proced)
(package! seq)

(package! exec-path-from-shell)

(package! catppuccin-theme)

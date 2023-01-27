;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Js/Ts/Css/Web packages

(package! tide)
(package! prettier-js)
(package! js2-mode)
(package! rjsx-mode)
(package! numpydoc)

;; Org Mode extensions

(package! org-super-agenda)
(package! ox-hugo)
(package! org-ref)
(package! citeproc-org)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-clock-csv)
(package! org-noter)
(package! org-gcal)

(package! elfeed-org)
(package! elfeed-summary)

(package! org-roam-ui)
(package! org-download)
(package! websocket)

;; MISC

(package! leetcode)

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

;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Js/Ts/Css/Web packages

(package! tide)
(package! prettier-js)
(package! js2-mode)
(package! rjsx-mode)

;; Org Mode extensions

(package! org-super-agenda)
(package! ox-hugo)
(package! org-ref)
(package! citeproc-org)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))

(package! websocket)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(package! org-download)

;; MISC

(package! leetcode)

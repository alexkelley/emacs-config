;; init.el -- Emacs configuration file

;; INSTALL PACKAGES
;; --------------------------------------
; straight.el bootstrap code -- https://github.com/raxod502/straight.el
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 4))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t) ; automatically install missing packages

(straight-use-package 'use-package)
(straight-use-package 'better-defaults)
(straight-use-package 'auto-complete)
(straight-use-package 'ein)
(straight-use-package 'elpy)
(straight-use-package 'flycheck)
(straight-use-package 'auctex)
(straight-use-package
 '(ess :type git
       :host github
       :repo "emacs-ess/ESS"
       :branch "v17.11"))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; BASIC CUSTOMIZATION ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(load-theme 'tango-dark t)

;; ignore case when searching
(setq case-fold-search t)

;; remove any whitespace at end of lines
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; require final newlines in files when they are saved
(setq require-final-newline t)

;; set backup file storage location
(setq save-place-file (concat user-emacs-directory "places"))
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
					       "backups"))))

; display filename in title
(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

;; modify frame size at startup
(when window-system (set-frame-size (selected-frame) 106 40))

;; remove window elements
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

; Make buffer names unique when the filenames are the same
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

; specify the fringe width for windows -- this sets both the left and
; right fringes to 10
(require 'fringe)
(fringe-mode 10)

; Saves the location of the point for when the file is reopened (>=emacs 25.1)
(save-place-mode 1)

; each line of text gets one line on the screen (i.e., text will run
; off the left instead of wrapping around onto a new line)
(setq truncate-lines t)
; truncate lines even in partial-width windows
(setq truncate-partial-width-windows t)

;; auto insert closing bracket
(electric-pair-mode 1)
;; turn on bracket match highlight
(show-paren-mode 1)

;; make typing delete/overwrite selected text
(delete-selection-mode 1)

;; display the current line and column numbers in the stats bar as well
(line-number-mode t)
(column-number-mode t)

;; Font
(set-face-attribute 'mode-line nil :font "DejaVu Sans Mono-10")
(set-face-attribute 'mode-line-inactive nil :font "DejaVu Sans Mono-10")

;; Interactively Do Things
(require 'ido)
(ido-mode t)
;; make ido display choices vertically
(setq ido-separator "\n")
;; display any item that contains chars you typed
(setq ido-enable-flex-matching t)

;; Dired
;; Make file sizes human-readable by default, sort version numbers
;; correctly, and put dotfiles and capital-letters first.
(setq-default dired-listing-switches "-alhv")
(setq dired-recursive-copies 'always)

;; Tramp
(setq tramp-default-method "ssh")
(setq tramp-verbose 6)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; CUA-mode
(cua-mode t)

;; Time & Date
(display-time)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.org.txt\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-visual-line-mode t)

;; Babel configuration
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (python . t)
   (sqlite . t)
   (shell . t)
   (R . t)
   (js . t)
   (latex . t)
   (awk . t)
   (css . t)
   (lisp . t)
   (sed . t)
   ()
   ))

;; Show syntax highlighting per language native mode in *.org
(setq org-src-fontify-natively t)
;; For languages with significant whitespace like Python:
(setq org-src-preserve-indentation t)

;;;;;;;;;;;;
;; Python ;;
;;;;;;;;;;;;
; use python 3 instead of python 2
;; (setq py-python-command "python3")
;; (setq elpy-rpc-python-command "python3")
;; (setq python-shell-interpreter "python3")
;; (setq org-babel-python-command "python3")

;; (setq indent-tabs-mode nil)
;; (setq python-shell-interpreter "ipython"
;;         python-shell-interpreter-args "--simple-prompt -i")

;; (pyvenv-activate "~/master_env")

;;;;;;;;;;;;;;;;;;;
;; Auto-Complete ;;
;;;;;;;;;;;;;;;;;;;
; start auto-complete with emacs
(require 'auto-complete)
;; (add-to-list 'ac-modes 'python-mode)
;; (add-to-list 'ac-modes 'R-mode)
;; (add-to-list 'ac-modes 'sql-mode)
;; (add-to-list 'ac-modes 'html-mode)
;; (add-to-list 'ac-modes 'js-mode)
;; (add-to-list 'ac-modes 'css-mode)
;; (global-auto-complete-mode t)
; do default config for auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)

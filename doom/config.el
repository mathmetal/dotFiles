;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                           ; On laptops it's nice to know how much power you have

;Don't show UTF-8 in modeline, show encoding onlyw when not UTF-8
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(setq doom-themes-treemacs-theme "doom-colors")






;; Install use-package
(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))

(use-package lsp-mode :ensure t)
(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp))

;; Optional packages
(use-package projectile :ensure t) ;; project management
(use-package yasnippet
  :ensure t
  :config (yas-global-mode)) ;; snipets
(use-package lsp-ui :ensure t) ;; UI for LSP
(use-package company :ensure t) ;; Auto-complete

;; Optional Flutter packages
(use-package hover :ensure t) ;; run app from desktop without emulator

;(require 'dart-mode)
;(defun auto-reload ()
;  (shell-command "kill -s SIGUSR1 $(cat /tmp/flutter.pid) && echo 'reload flutter...'"))
;
;(add-hook 'dart-mode-hook
;          (lambda ()
;            (add-hook 'after-save-hook 'auto-reload nil 'make-it-local)))

;Trying to fix lsp
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq gc-cons-threshold 1000000000)

 ;; Never ding at me, ever.
   ring-bell-function 'ignore
   ;; Prompts should go in the minibuffer, not in a GUI.
   use-dialog-box nil
(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)
(setq custom-file (make-temp-file ""))
(setq custom-safe-themes t)
(unbind-key "C-x C-f") ;; find-file-read-only
(unbind-key "C-x C-d") ;; list-directory
(unbind-key "C-z") ;; suspend-frame
(unbind-key "M-o") ;; facemenu-mode
(unbind-key "<mouse-2>") ;; pasting with mouse-wheel click
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq require-final-newline t)

(ignore-errors (set-frame-font "Menlo-14"))
(use-package all-the-icons)
(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

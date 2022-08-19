;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(load! "+ui")
(load! "+prog")
(load! "+custom")


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Rand01ph"
      user-mail-address "tanyawei1991@gmail.com")

(setq-default delete-by-moving-to-trash t
              x-stretch-cursor t)

(setq! undo-limit 104857600
       auto-save-default t
       gc-cons-threshold 1073741824
       read-process-output-max 1048576)

(global-subword-mode 1)

(define-key! global-map "C-s" #'+default/search-buffer)

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 100))

(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace 1)))

(setq-default custom-file (expand-file-name ".custom.el" doom-user-dir))
(when (file-exists-p custom-file) (load custom-file))

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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size (if (> (display-pixel-width) 1920) 24 12) :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Sarasa Mono Slab SC" :size (if (> (display-pixel-width) 1920) 24 12)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

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

(setq evil-escape-key-sequence "kj")

;; 切换窗口
(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; 方向
      "<left>"   #'evil-window-left
      "<down>"   #'evil-window-down
      "<up>"     #'evil-window-up
      "<right>"  #'evil-window-right
      ;; 交换窗口
      "C-<left>"   #'+evil/window-move-left
      "C-<down>"   #'+evil/window-move-down
      "C-<up>"     #'+evil/window-move-up
      "C-<right>"  #'+evil/window-move-right
      )

(after! doom-modeline
  (custom-set-variables '(doom-modeline-buffer-file-name-style 'relative-to-project)
                        '(doom-modeline-major-mode-icon t)
                        '(doom-modeline-modal-icon nil))
  (nyan-mode t))


(after! leetcode
  (setq leetcode-prefer-language "python3"
        leetcode-prefer-sql "mysql"
        leetcode-save-solutions t
        leetcode-directory "~/leetcode"))


(use-package! ox-confluence
  :defer 3
  :ensure nil
  :after org)

;; org-download
(after! org-download
  (setq org-download-method 'directory
        org-download-image-dir "./images/"))

(use-package! wakatime-mode
  :config (global-wakatime-mode))

;;; Org-gtd
(use-package! org-gtd
  :after org
  :config
  (org-edna-mode)
  (setq org-gtd-directory "~/org/gtd")
  (setq org-gtd-default-file-name "actionable")
  (setq org-edna-use-inheritance t)
  (map!
   :leader
   (:prefix-map ("d" . "org-gtd")
    :desc "Capture"        "c"  #'org-gtd-capture
    :desc "Engage"         "e"  #'org-gtd-engage
    :desc "Process inbox"  "p"  #'org-gtd-process-inbox
    :desc "Show all next"  "n"  #'org-gtd-show-all-next
    :desc "Stuck projects" "s"  #'org-gtd-show-stuck-projects))

  (map!
   :map org-gtd-process-map
   :desc "Choose"         "C-c C-c" #'org-gtd-choose))

(use-package! hungry-delete
  :config
  (setq-default hungry-delete-chars-to-skip " \t\v")
  (setq hungry-delete-except-modes '(help-mode minibuffer-mode minibuffer-inactive-mode))
  (add-hook! 'after-init-hook #'global-hungry-delete-mode))

(custom-set-variables '(wakatime-api-key "96f909e0-00a6-4e3c-b3fe-d7010bf8b5de"))

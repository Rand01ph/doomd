;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq-default fill-column 120
              delete-trailing-lines t)

(add-hook! 'text-mode-hook 'auto-fill-mode)

;; DON'T use (`font-family-list'), it's unreliable on Linux
;; https://github.com/laishulu/Sarasa-Mono-SC-Nerd
(when (find-font (font-spec :name "Sarasa Mono SC Nerd"))
  (setq doom-font (font-spec :family "Sarasa Mono SC Nerd" :size 20)
        doom-variable-pitch-font (font-spec :family "Sarasa Mono SC Nerd")
        doom-unicode-font (font-spec :family "Sarasa Mono SC Nerd")
        doom-big-font (font-spec :family "Sarasa Mono SC Nerd" :size 24)))

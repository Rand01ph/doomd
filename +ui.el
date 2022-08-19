;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq-default fill-column 120
              delete-trailing-lines t)

(add-hook! 'text-mode-hook 'auto-fill-mode)

(use-package! nyan-mode
  :config
  (setq nyan-animate-nyancat t
        nyan-wavy-trail t
        nyan-cat-face-number 4
        nyan-bar-length 16
        nyan-minimum-window-width 64)
  (add-hook! 'doom-modeline-hook #'nyan-mode))

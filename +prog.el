;;; ~/.doom.d/+prog.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPANY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! company
  (setq company-idle-delay 0.2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PYTHON
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! python
  (setq python-indent-offset 4
        python-shell-interpreter "python3"
        pippel-python-command "python3"
        conda-env-home-directory (expand-file-name "~/.conda")
        importmagic-python-interpreter "python3"
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8")

(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

  ;; if you use pyton2, then you could comment the following 2 lines
  ;; (setq python-shell-interpreter "python2"
  ;;       python-shell-interpreter-args "-i")

  ;; ignore some linting info
  (if (featurep! :tools lsp)
      (setq lsp-pyls-plugins-pycodestyle-ignore '("E501")
            lsp-pyls-plugins-pylint-args [ "--errors-only" ]))
  )


(after! lsp-pyright
  (setq lsp-pyright-python-executable-cmd "python3"))

(use-package! py-isort
  :defer t
  :init
  (define-minor-mode python-isort-autosave-mode
    "Isort autosave mode."
    :lighter " Isort"
    :global nil
    (when (not (derived-mode-p 'python-mode))
      (error "Isort only works with Python buffers"))
    (if python-isort-autosave-mode
        (add-hook! 'before-save-hook :local #'py-isort-before-save)
      (remove-hook! 'before-save-hook :local #'py-isort-before-save)))

  (add-hook! 'python-mode-hook #'python-isort-autosave-mode))

(use-package! python-black
  :after python
  :bind (:map python-mode-map
              ("C-c C-f" . python-black-buffer)))


;; (use-package! importmagic
;;   :defer t
;;   :hook (python-mode . importmagic-mode)
;;   :commands (importmagic-fix-imports importmagic-fix-symbol-at-point)
;;   :config
;;   (dolist (func '(importmagic-fix-imports importmagic-fix-symbol-at-point))
;;     (advice-add func :before #'revert-buffer-no-confirm)))


(after! pipenv
  (setq pipenv-with-projectile t)
  ;; Override pipenv--clean-response to trim color codes
  (defun pipenv--clean-response (response)
    "Clean up RESPONSE from shell command."
    (replace-regexp-in-string "\n\\[0m$" "" (s-chomp response)))

  ;; restart flycheck-mode after env activate and deactivate
  (dolist (func '(pipenv-activate pipenv-deactivate))
    (advice-add func :after #'reset-flycheck)))


(after! conda
  ;; restart flycheck-mode after env activate and deactivate
  (dolist (func '(conda-env-activate conda-env-deactivate))
    (advice-add func :after #'reset-flycheck)))


;; For pytest-mode
(set-evil-initial-state! '(comint-mode) 'normal)

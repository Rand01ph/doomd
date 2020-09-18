;;; ~/.doom.d/+custom.el -*- lexical-binding: t; -*-

(define-minor-mode dired-follow-mode "Diplay file at point in dired after a move."
  :lighter " dired-f"
  :global t
  (if dired-follow-mode (advice-add 'dired-next-line
                                    :after (lambda ()
                                             (dired-display-file)))
    (advice-remove 'dired-next-line (lambda ()
                                      (dired-display-file)))))


;;PlantUML
(setq org-plantuml-jar-path "~/.doom.d/extensions/plantuml.jar")
(setq plantuml-jar-path "~/.doom.d/extensions/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)


(defun insert-current-date ()
  "Insert the current date"
  (interactive "*")
  (insert (format-time-string "%Y-%m-%d %A" (current-time)))
  )

(defun current-date ()
  (format-time-string "%Y-%m-%d %A" (current-time)))

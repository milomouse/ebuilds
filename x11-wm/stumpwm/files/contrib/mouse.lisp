(in-package #:stumpwm)

(export '(*mouse-increment*
          ratmove
          exit-ratmove))

(defvar *mouse-increment* 10)
(defvar *mouse-map* (make-sparse-keymap))

(defun set-mouse-increment (val)
  (setf *mouse-increment* val)
  (update-mouse-map))

(defun update-mouse-map ()
  (let ((m (or *mouse-map* (setf *mouse-map* (make-sparse-keymap)))))
    (let ((i *mouse-increment* ))
      (labels ((dk (m k c)
                 (define-key m k (format nil c i))))
        (dk m (kbd "Up") "ratrelwarp 0 -~D")
        (dk m (kbd "C-p") "ratrelwarp 0 -~D")
        (dk m (kbd "p") "ratrelwarp 0 -~D")
        (dk m (kbd "k") "ratrelwarp 0 -~D")

        (dk m (kbd "Down") "ratrelwarp 0 ~D")
        (dk m (kbd "C-n") "ratrelwarp 0 ~D")
        (dk m (kbd "n") "ratrelwarp 0 ~D")
        (dk m (kbd "j") "ratrelwarp 0 ~D")

        (dk m (kbd "Left") "ratrelwarp -~D 0")
        (dk m (kbd "C-b") "ratrelwarp -~D 0")
        (dk m (kbd "b") "ratrelwarp -~D 0")
        (dk m (kbd "h") "ratrelwarp -~D 0")

        (dk m (kbd "Right") "ratrelwarp ~D 0")
        (dk m (kbd "C-f") "ratrelwarp ~D 0")
        (dk m (kbd "f") "ratrelwarp ~D 0")
        (dk m (kbd "l") "ratrelwarp ~D 0")
        (define-key m (kbd "RET") "ratclick")
        (define-key m (kbd "C-g") "exit-ratmove")
        (define-key m (kbd "ESC") "exit-ratmove")))))

(update-mouse-map)

(defcommand ratmove () ()
   (push-top-map *mouse-map*))

(defcommand exit-ratmove () ()
  (pop-top-map))

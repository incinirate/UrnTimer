(import lua/math math)

(import extlib/cc/os os)
(import extlib/cc/term term)
(import extlib/cc/colors colors)

(import timerlib/buffer buffer)

(define width (term/getSize)) 
(define height (nth (list (term/getSize)) 2))

(defun ev-char (c) 57)
(defun draw ()
  (buffer/draw-circle (/ width 2) (succ (/ height 2)) 8 "7" " " "0")
  (buffer/draw-buff buffer/screen-buffer))

(defun update ()
  (os/pullEvent))

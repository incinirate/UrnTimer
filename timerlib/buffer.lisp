(import extlib/cc/term term)
(import extlib/cc/io (read))
(import timerlib/util (assert-types! gen-lv cut-across slot-across))

(defmacro inset-one (buff x y va vl) :hidden
  (with (fstr (gensym))
    `(setf! (nth (nth (.> ,buff :cur-rep) ,y) ,va)
      (with (,fstr (nth (nth (.> ,buff :cur-rep) ,y) ,va))
        (.. (string/sub ,fstr 1 (pred ,x)) ,vl (string/sub ,fstr (succ ,x)))))))

(defun set-pixel (buff x y d b f)
  (setf! x (math/floor x))
  (setf! y (math/floor y))
  (when (and (> x 0) (<= x (.> buff :width))
           (> y 0) (<= y (.> buff :height)))
    (progn 
      (cut-across (d b f)
        (when (! (nil? <>))
          (inset-one buff x y <2> <1>)))
      (setf! (nth (.> buff :old-rep) y) true))))

(defun draw-circle (x0 y0 radius b d c)
  (let* [(x radius)
         (y 0)
         (err 0)]
    (while (>= x y)
      (set-pixel screen-buffer (+ x0 x) (+ y0 y) d b c)
      (set-pixel screen-buffer (+ x0 y) (+ y0 x) d b c)
      (set-pixel screen-buffer (- x0 y) (+ y0 x) d b c)
      (set-pixel screen-buffer (- x0 x) (+ y0 y) d b c)
      (set-pixel screen-buffer (- x0 x) (- y0 y) d b c)
      (set-pixel screen-buffer (- x0 y) (- y0 x) d b c)
      (set-pixel screen-buffer (+ x0 y) (- y0 x) d b c)
      (set-pixel screen-buffer (+ x0 x) (- y0 y) d b c)

      (inc! y)
      (cond
        [(<= err 0)
          (setf! err (+ err (* y 2) 1))]
        [(> err 0)
          (dec! x)
          (setf! err (- err (* y 2) 1))]))))

(defun draw-buff (buff)
  (for i 1 (.> buff :height) 1
    (let* [(crep (nth (.> buff :cur-rep) i))
           (orep (nth (.> buff :old-rep) i))]
      (when orep
        (term/setCursorPos 1 i)
        (apply term/blit (slot-across (1 3 2)
                           (nth crep <>)))
        (setf! (nth (.> buff :old-rep) i) false)))))

(defun gen-buffer (w h)
  (assert-types! w h number)
  (with (new-buff {})
    (set-idx! new-buff :old-rep (gen-lv true h))
    (set-idx! new-buff :cur-rep (gen-lv (gen-lv (string/rep "0" w) 3) h))
    (set-idx! new-buff :width w)
    (set-idx! new-buff :height h)
    new-buff))

(define screen-buffer (gen-buffer (term/getSize)))
(print! "Buffer loaded!")

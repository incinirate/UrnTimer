(defmacro assert-types! (&args ty)
  `(progn ,@(map (lambda (x) `(assert-type! ,x ,ty)) args)))

(defun gen-lv (val size)
  (let* [(out '())]
    (if (list? val)
      (for i 1 size 1
        (push-cdr! out (append '() val)))
      (for i 1 size 1 
        (push-cdr! out val)))
    out))

(defun gen-lf (func size)
  (let* [(out '())]
    (for i 1 size 1 
      (push-cdr! out (func i)))
    out))

(defun slot-num? (tag)
  (when (symbol? tag)
    (let* [(elm (symbol->string tag))
           (match (string/match elm "<%d*>"))]
      (when (= match elm)
        (string/sub match 2 (pred (n match)))))))

(defun parse-slots (args-in &body)
  (let [(args (if (nil? args-in) '() args-in))
        (call '())]
    (for-each item body
      (with (slot-chk (slot-num? item))
        (if (! (nil? slot-chk))
          (if (= slot-chk "")
            (with (symb (gensym))
              (push-cdr! args symb)
              (push-cdr! call symb))
            (if (>= (n args) (tonumber slot-chk))
              (push-cdr! call (nth args (tonumber slot-chk)))
              (if (= (succ (n args)) (tonumber slot-chk))
                (with (symb (gensym))
                  (push-cdr! args symb)
                  (push-cdr! call symb))
                (error! (string/format "skipping from arg %n to %n" (n args) (tonumber slot-chk)) 2))))
          (if (list? item)
            (with (recurse-list (parse-slots args (unpack item)))
              (push-cdr! call (cadr recurse-list)))
            (push-cdr! call item)))))
    (list args call)))

(defmacro cut-across (vars &body)
  (let* [(tree (parse-slots nil body))
         (args (car tree))
         (call (caaadr tree))
         (counter 0)]
    (cond 
      [(= (n args) 2)
        `(progn ,@(map (lambda (av) 
                         (setf! counter (succ counter))
                         `((lambda ,args ,call) ,av ,counter)) vars))]
      [(= (n args) 1)
        `(progn ,@(map (lambda (av) `((lambda ,args ,call) ,av)) vars))]
      [true (error! "Expected either one or two arguments to cut-across" 2)])))

(defmacro slot-across (vars &body)
  (let* [(tree (parse-slots nil body))
         (args (car tree))
         (call (caaadr tree))
         (counter 0)]
    (cond 
      [(= (n args) 2)
        `(list ,@(map (lambda (av) 
                         (setf! counter (succ counter))
                         `((lambda ,args ,call) ,av ,counter)) vars))]
      [(= (n args) 1)
        `(list ,@(map (lambda (av) `((lambda ,args ,call) ,av)) vars))]
      [true (error! "Expected either one or two arguments to slot-across" 2)])))



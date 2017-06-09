(import timerlib/buffer buffer)

(define state-list '("timer"))

(let* [(states ,(with (result `{})
                  (for-each state state-list
                    (push-cdr! result state)
                    (push-cdr! result `(progn
                                         (import ,(string->symbol (.. "states/" state)))
                                         { "update" ,(string->symbol (.. "states/" state "/update"))
                                           "draw"   ,(string->symbol (.. "states/" state "/draw")) })))
                  result))]
  (let* [(state "timer")
         (state-idx (.> states state))
         (running true)]
    (while running
      (call state-idx :update)
      (call state-idx :draw))))

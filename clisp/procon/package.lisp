(in-package :cl-user)

(defpackage :asserts
  (:use :cl)
  ; procon/lib/asserts.lisp
  (:export :assert-solve)
  )

(defpackage :queue
  (:use :cl)
  ; procon/lib/queue.lisp
  (:export :queue
           :enqueue
           :dequeue
           :qfront
           :qemptyp
           :qfullp
           :qclear
           :queue-front
           :queue-rear
           :queue-count
           :queue-buffer
           :make-queue
           ))

(defpackage :search
  (:use :cl)
  ; procon/lib/search.lisp
  (:export :binary-search)
  )

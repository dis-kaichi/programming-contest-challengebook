(in-package #:asserts)
;; ----------------------------------------
;; Assert関連
;; ----------------------------------------

(defmacro assert-solve (answer solve &rest label)
  (let ((msg (gensym))
        (my-answer (gensym))
        )
    `(progn
       (setf ,msg (if (first ',label)
                      (format nil "[~a] " (first ',label))
                      ""))
       (setf ,my-answer ,solve)
       (assert (equal ,answer ,my-answer)
               ()
               "~aFailed. value is ~a, but given ~a." ,msg ,answer ,my-answer
               ))))


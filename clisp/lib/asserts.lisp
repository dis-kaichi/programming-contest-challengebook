;; ----------------------------------------
;; Assert関連
;; ----------------------------------------

(defmacro assert-solve (answer solve &rest label)
  (let ((msg (gensym)))
    `(progn
       (setf ,msg (if (first ',label)
                      (format nil "[~a] " (first ',label))
                      ""))
       (assert (equal ,answer ,solve)
               ()
               "~aFailed. value is ~a." ,msg ,answer
               ))))


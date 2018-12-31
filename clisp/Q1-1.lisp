;; ----------------------------------------
;; くじびき
;; ----------------------------------------

(defun parameter1 ()
  (let ((n 3)
        (m 10)
        (k '(1 3 4))
        (answer "Yes"))
    (values n m k answer)))

(defun parameter2 ()
  (let ((n 3)
        (m 9)
        (k '(1 3 5))
        (answer "No"))
    (values n m k answer)))

(defun solve (n m k)
  (dotimes (x1 n)
    (dotimes (x2 n)
      (dotimes (x3 n)
        (dotimes (x4 n)
          (when (= m (+ (nth x1 k)
                        (nth x2 k)
                        (nth x3 k)
                        (nth x4 k)))
            ;(format t "~D ~D ~D ~D~%" (nth x1 k)
            ;        (nth x2 k)
            ;        (nth x3 k)
            ;        (nth x4 k))
            (return-from solve "Yes"))))))
  "No")

(defun main (&rest argv)
  (multiple-value-bind (n m k answer) (parameter1)
    (assert-solve answer (solve n m k) "Test1"))
  (multiple-value-bind (n m k answer) (parameter2)
    (assert-solve answer (solve n m k) "Test2")))

(main)


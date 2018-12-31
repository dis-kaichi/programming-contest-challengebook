
;; ----------------------------------------
;; くじびき : O(n^3 logn) version
;; ----------------------------------------

(defun parameter1 ()
  (let ((n 3)
        (m 10)
        (k '(1 3 5))
        (answer "Yes"))
    (values n m k answer)))

(defun parameter2 ()
  (let ((n 3)
        (m 9)
        (k '(1 3 5))
        (answer "No"))
    (values n m k answer)))

(defun solver (n m k)
  (let ((f nil))
    (dotimes (a n)
      (dotimes (b n)
        (dotimes (c n)
          (when (binary-search
                  k
                  (- m (nth a k) (nth b k) (nth c k)) )
            (setf f t)))))
    (if f
        "Yes"
        "No")))

(defun solve ()
  (multiple-value-bind (n m k answer) (parameter1)
    (assert-solve answer (solver n m k) "Test1"))
  (multiple-value-bind (n m k answer) (parameter2)
    (assert-solve answer (solver n m k) "Test2")))

(defun main (&rest args)
  (solve))

(main)

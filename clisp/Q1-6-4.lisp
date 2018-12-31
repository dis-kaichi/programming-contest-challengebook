
;; ----------------------------------------
;; くじびき : O(n^2 logn) version
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
  (let ((f nil)
        (kk (make-array (expt n 2) :initial-element 0)))
    (dotimes (c n)
      (dotimes (d n)
        (setf (aref kk (+ (* c n) d))
              (+ (nth c k) (nth d k)))))
    (setf kk (sort kk #'>))
    (dotimes (a n)
      (dotimes (b n)
        (when (binary-search kk (- m (nth a k) (nth b k)))
          (setf f t))))
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

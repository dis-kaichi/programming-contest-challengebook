
;; ----------------------------------------
;; Ants (POJ No.1852)
;; ----------------------------------------

(defun parameter1 ()
  (let ((L 10)
        (n 3)
        (x '(2 6 7))
        (answer (values 4 8)))
    (values L n x answer)))

(defun search-min-time (L n x)
  (let ((value 0))
    (dotimes (i n)
      (setf value (max value (min (nth i x) (- L (nth i x))))))
    value))

(defun search-max-time (L n x)
  (let ((value 0))
    (dotimes (i n)
      (setf value (max value (max (nth i x) (- L (nth i x))))))
    value))

(defun solver (L n x)
  (let ((min-t (search-min-time L n x))
        (max-t (search-max-time L n x)))
    (values min-t max-t)))

(defun solve ()
  (multiple-value-bind (L n x answer) (parameter1)
    (assert-solve answer (solver L n x) "Test1")))

(defun main (&rest args)
  (solve))

(main)

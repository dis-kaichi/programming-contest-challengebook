
;; ----------------------------------------
;; 三角形
;; ----------------------------------------
(defun parameter1 ()
  (let ((n 5)
        (a '(2 3 4 5 10))
        (answer 12))
    (values n a answer)))

(defun parameter2 ()
  (let ((n 4)
        (a '(4 5 10 20))
        (answer 0))
    (values n a answer)))

(defun solver (n a)
  (let ((ans 0))
    (loop for i from 0 to (- n 1)
          do (loop for j from (+ i 1) to (- n 1)
                   do (loop for k from (+ j 1) to (- n 1)
                            do (let* ((ai (nth i a))
                                      (aj (nth j a))
                                      (ak (nth k a))
                                      (len (+ ai aj ak))
                                      (ma (max ai aj ak))
                                      (res (- len ma)))
                                 (when (< ma res)
                                   (setf ans (max ans len)))))))
    ans))

(defun solve ()
  (multiple-value-bind (n a answer) (parameter1)
    (assert-solve answer (solver n a) "Test1"))
  (multiple-value-bind (n a answer) (parameter2)
    (assert-solve answer (solver n a) "Test2")))

(defun main (&rest argv)
  (solve))

(main)


;; ----------------------------------------
;; 部分和問題
;; ----------------------------------------

(defun parameter1 ()
  (let ((n 4)
        (a '(1 2 4 7))
        (k 13)
        (answer "Yes"))
    (values n a k answer)))

(defun parameter2 ()
  (let ((n 4)
        (a '(1 2 4 7))
        (k 15)
        (answer "No"))
    (values n a k answer)))

;(defun dfs (n a k i ss)
;  (if (= i n)
;      (= ss k)
;      (if (dfs n a k (+ i 1) ss)
;          t
;          (if (dfs n a k (+ i 1) (+ ss (nth i a)))
;              t
;              nil))))
(defun dfs (n a k i ss)
  (cond ((= i n) (= ss k))
        ((dfs n a k (+ i 1) ss) t)
        ((dfs n a k (+ i 1) (+ ss (nth i a))) t)
        (t nil)))

(defun solver (n a k)
  (if (dfs n a k 0 0)
      "Yes"
      "No"))

(defun solve ()
  (multiple-value-bind (n a k answer) (parameter1)
    (assert-solve answer (solver n a k) "Test1"))
  (multiple-value-bind (n a k answer) (parameter2)
    (assert-solve answer (solver n a k) "Test2")))

(defun main (&rest args)
  (solve))

(main)


;; ----------------------------------------
;; Search系
;; ----------------------------------------

(defun binary-search (xs x)
  (cond
    ((typep xs 'simple-vector)
     (binary-search-array xs x))
    ((typep xs 'cons)
     (binary-search-cons xs x)
     )
    (t nil)))

(defun binary-search-cons (xs x)
  (let ((l 0)
        (r (length xs)))
    (loop
      (if (< (- r l) 1)
          (return nil)
          (progn
            (let ((i (floor (/ (+ l r) 2))))
              (if (= x (nth i xs))
                  (return t)
                  (if (< (nth i xs) x)
                      (setf l (+ i 1))
                      (setf r i)))))))))

(defun binary-search-array (xs x)
  (let ((l 0)
        (r (length xs)))
    (loop
      (if (< (- r l) 1)
          (return nil)
          (let ((i (floor (/ (+ l r) 2))))
            (if (= x (aref xs i))
                (return t)
                (if (< (aref xs i) x)
                    (setf l (+ i 1))
                    (setf r i))))))))

;(binary-search '(2 3 4 10 40) 10)
;(binary-search '(2 3 4 10 40) 11)

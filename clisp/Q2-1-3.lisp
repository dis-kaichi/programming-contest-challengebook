
;; ----------------------------------------
;; Lake Counting
;; ----------------------------------------

(defun parameter1 ()
  (let ((n 10)
        (m 12)
        (field '("W........WW."
                 ".WWW.....WWW"
                 "....WW...WW."
                 ".........WW."
                 ".........W.."
                 "..W......W.."
                 ".W.W.....WW."
                 "W.W.W.....W."
                 ".W.W......W."
                 "..W.......W."))
        (answer 3))
    (values n m field answer)))

(defun dfs (n a k i ss)
  (if (= i n)
      (= ss k)
      (if (dfs n a k (+ i 1) ss)
          t
          (if (dfs n a k (+ i 1) (+ ss (nth i a)))
              t
              nil))))

(defvar *field* (make-hash-table :test #'equal))

(defun convert-lake (x)
  (if (char= x #\W)
      1
      0))

(defun lakep (x y)
  (= (gethash (list x y) *field*) 1))

(defun copy-to-global-field (n m field)
  (dotimes (i n)
    (let ((line (nth i field)))
      (dotimes (j m)
        (setf (gethash (list i j) *field*)
              (convert-lake (schar line j)))))))

(defun dfs (n m x y)
  (setf (gethash (list x y) *field*) 0)
  (loop for dx from -1 to 1
        do
        (loop for dy from -1 to 1
              do
              (let ((nx (+ x dx))
                    (ny (+ y dy)))
                (when (and (<= 0 nx)
                           (< nx n)
                           (<= 0 ny)
                           (< ny m)
                           (lakep nx ny))
                  (dfs n m nx ny))))))

(defun solver (n m field)
  (copy-to-global-field n m field)
  (let ((res 0))
    (dotimes (i n)
      (dotimes (j m)
        (when (lakep i j)
          (dfs n m i j)
          (incf res))))
    res))

(defun solve ()
  (multiple-value-bind (n m field answer) (parameter1)
    (assert-solve answer (solver n m field) "Test1")))

(defun main (&rest args)
  (solve))

(main)

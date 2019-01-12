;; ----------------------------------------
;; Tips
;; ----------------------------------------

;; 1. 再帰関数(階乗)
(defun fact (n)
  (if (= n 0)
      1
      (* n (fact (1- n)))))

;; 2. 再帰関数(フィボナッチ)
(defun fib (n)
  (if (<= n 1)
      n
      (+ (fib (1- n)) (fib (- n 2)))))

;; 3. メモ化(フィボナッチ)
(defvar *fib-table* (make-hash-table :test #'equal))
(defun fib-memo (n)
  (if (<= n 1)
      n
      (if (null (gethash n *fib-table* nil))

          (setf (gethash n *fib-table*) (+ (fib-memo (- n 1))
                                           (fib-memo (- n 2))))
          (gethash n *fib-table*))))

;(maphash #'(lambda (key value)
;             (format t "~A => ~A~%" key value))
;         *fib-table*)

;; 4. スタック
(let ((xs '()))
  (push 'a xs)
  (push 'b xs)
  (print (pop xs))
  (print (pop xs))
  "Done"
  )

;; 5. キュー
;;; lib/queue.lispを参照
(setf qq (make-queue))
(dotimes (x 16)
  (enqueue qq x))
(enqueue qq 1000)     ;; bufferのサイズを超えると追加されなくなる


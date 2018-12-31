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
;;; 参考 : http://www.geocities.jp/m_hiroi/xyzzy_lisp/abclisp10.html
; キューの定義
(defstruct queue (front nil) (rear nil))

; データを入れる
(defun enqueue (queue item)
  (let ((new-cell (list item)))
    (if (queue-front queue)
        ; 最終セルを書き換える
        (setf (cdr (queue-rear queue)) new-cell)
        ; キューは空の状態
        (setf (queue-front queue) new-cell))
    (setf (queue-rear queue) new-cell)))

; データを取り出す
(defun dequeue (queue)
  (if (queue-front queue)
      (prog1
        (pop (queue-front queue))
        (unless (queue-front queue)
          ; キューは空になった
          (setf (queue-rear queue) nil)))))

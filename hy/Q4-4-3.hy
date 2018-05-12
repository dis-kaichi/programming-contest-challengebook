#!/usr/bin/env hy

;; ----------------------------------------
;; 個数制限付きナップサック
;; ----------------------------------------
(import [lib.matrix [transpose]])
(import [lib.operations [safe-get]])

(defn parameter1 []
  ;; Answer : 11 (1: 2, 2: 1, 3: 1)
  (setv n 3)
  (setv (, w v m) (-> [[3 2 5]
                       [2 4 1]
                       [4 3 3]]
                      transpose))
  (setv W 12)
  (, n w v m W))

(defn solve []
  ;; Parameters
  (setv (, n w v m W) (parameter1))

  ;; Main
  (setv dp {})   ; DPテーブル
  (setv deq {})  ; インデックス
  (setv deqv {}) ; 値

  (for [i (range n)]
    (for [a (range (get w i))]
      (setv (, s t) (, 0 0)) ; デックの先頭と末尾
      (setv j 0)
      (while (<= (+ (* j (get w i)) a) W)
        ;; デックの末尾にjを追加
        (setv val (- (safe-get dp (+ (* j (get w i)) a) 0)
                     (* j (get v i))))
        (while(and (< s t)
                   (<= (get deqv (dec t)) val))
          (-= t 1))
        (assoc deq t j)
        (assoc deqv t val)
        (+= t 1)
        ;; デックの先頭を取り出す
        (assoc dp (+ (* j (get w i)) a) (+ (get deqv s) (* j (get v i))))
        (when (= (get deq s) (- j (get m i)))
          (+= s 1))
        (+= j 1))))
  (print (get dp W)))

(defmain
  [&rest args]
  (solve))

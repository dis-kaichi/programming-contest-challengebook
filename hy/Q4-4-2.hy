#!/usr/bin/env hy

;; ----------------------------------------
;; スライド最小値
;; ----------------------------------------
(defn parameter1 []
  ;; Answer : 1 3 2
  (setv n 5)
  (setv k 3)
  (setv a [1 3 5 4 2])
  (, n k a))

(defn solve []
  ;; Parameters
  (setv (, n k a) (parameter1))

  ;; Main
  (setv b {})
  (setv deq {})

  (setv (, s t) (, 0 0)) ;; デックの先頭と末尾

  (for [i (range n)]
    ;; デックにiを追加
    (while (and (< s t)
                (>= (get a (get deq (dec t)))
                    (get a i)))
      (-= t 1))
    (assoc deq t i)
    (+= t 1)

    (when (>= (+ i (- k) 1) 0)
      (assoc b (+ i (- k) 1) (get a (get deq s)))
      (when (= (get deq s) (+ i (- k) 1))
        ;; デックの先頭を取り出す
        (+= s 1))))

  (setv res [])
  (for [i (range (inc (- n k)))]
    (.append res (get b i)))
  (print (.join " "(map str res))))

(defmain
  [&rest args]
  (solve))

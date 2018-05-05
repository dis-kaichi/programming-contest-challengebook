#!/usr/bin/env hy

;; ----------------------------------------
;; コインゲーム２
;; ----------------------------------------
(import [lib.sequences [max-element]])

(defn parameter1 []
  ;; Answer : Alice
  (setv n 3)
  (setv k 3)
  (setv a [1 3 4])
  (setv x [5 6 7])
  (, n k a x))

(defn parameter2 []
  ;; Answer : Bob
  (setv n 3)
  (setv k 3)
  (setv a [1 3 4])
  (setv x [5 6 8])
  (, n k a x))

;; grundy数を動的計画法により計算する配列
(setv *grundy* {})

(defn solve []
  ;; Parameters
  (setv (, N K A X) (parameter1))

  ;; Main

  ;; 0枚で自分に回ってきたら負け
  (global *grundy*)
  (assoc *grundy* 0 0)

  ;; grundy数を計算
  (setv max-x (max-element X))
  (for [j (range 1 (inc max-x))]
    (setv s (set))
    (for [i (range K)]
      (when (<= (get A i) j)
        (.add s (get *grundy* (- j (get A i))))))

    (setv g 0)
    (while (in g s)
      (+= g 1))
    (assoc *grundy* j g))

  ;; 勝敗を判定
  (setv x 0)
  (for [i (range N)]
    (^= x (get *grundy* (get X i))))

  (if ((comp not zero?) x)
    (print "Alice")
    (print "Bob")))


(defmain
  [&rest args]
  (solve))

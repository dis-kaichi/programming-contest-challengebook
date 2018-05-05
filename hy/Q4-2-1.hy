#!/usr/bin/env hy

;; ----------------------------------------
;; コインのゲーム
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : Alice
  (setv x 9)
  (setv k 2)
  (setv a [1 4])
  (, x k a))

(defn parameter2 []
  ;; Answer : Bob
  (setv x 10)
  (setv k 2)
  (setv a [1 4])
  (, x k a))

(defn solve []
  ;; Parameters
  (setv (, X K A) (parameter1))

  ;; Main
  (setv win {})  ;; 動的計画法で用いる配列

  (assoc win 0 False)
  (for [j (range 1 (inc X))]
    ;; 相手を負けの状態にすることができれば勝ち
    (assoc win j False)
    (for [i (range K)]
      (setv wj (and (<= (get A i) j) (not (get win (- j (get A i))))))
      (assoc win j (or (get win j) wj))))

  (if (get win X)
    (print "Alice")
    (print "Bob")))

(defmain
  [&rest args]
  (solve))

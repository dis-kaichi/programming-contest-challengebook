#!/usr/bin/env hy

;; ----------------------------------------
;; Mine Layer
;; ----------------------------------------
(import sys)

(defn parameter1 []
  ;; Answer : 1
  (setv R 3)
  (setv C 3)
  (setv A [[2 2 1]
           [3 4 3]
           [2 3 2]])
  (, R C A))

(defn total [a n]
  (setv res 0)
  ;; 3で割ったあまりで場合分け
  (if (or (= (% n 3) 1)
          (= (% n 3) 2))
    (for [i (range 0 n 3)]
      (+= res (get a i)))
    (for [i (range 1 n 3)]
      (+= res (get a i))))
  res)

;; サイズnの一次元版で真ん中の値を求める
(defn center [a n]
  (setv res 0)
  ;; 3で割ったあまりで場合分け
  (if (= (% n 3) 1)
    (do
      (setv res (total a n))
      (for [i (range 1 (// n 2) 3)]
        (-= res (get a i))
        (-= res (get a (- n i 1)))))
    (if (= (% n 3) 2)
      (do
        (setv res (total a n))
        (for [i (range 0 (// n 2) 3)]
          (-= res (get a i))
          (-= res (get a (- n i 1)))))
      (do
        (setv res 0)
        (for [i (range 0 (// n 2) 3)]
          (+= res (get a i))
          (+= res (get a (- n i 1))))
        (-= res (total a n)))))
  res)

(defn solve []
  ;; Parameters
  (setv (, R C A) (parameter1))

  ;; Main

  ;; 各行の和を求める
  (setv rows (* [0] 49))
  (for [i (range R)]
    (assoc rows i (total (get A i) C)))

  ;; 一次元版の問題を解く
  (setv ans (center rows R))
  (print ans)
  )

(defmain
  [&rest args]
  (solve))

#!/usr/bin/env hy

;; ----------------------------------------
;; 双六
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor]])

(setv data
  ["4 11" ;; a b
   ])

(defn extgcd [a b]
  ;; ax + by = d となる [x y d] を返す
  (if (zero? b)
    [1 0 a]
    (do
      (setv prev (extgcd b (% a b)))
      [(second prev)
       (- (first prev) (* (second prev) (floor (/ a b))))
       a])))

(defn solve []
  ;; 入力値
  (setv (, a b) (-> data first (.split " ") ((partial map int))))
  (setv (, x y d) (extgcd a b))
  (setv result (* [0] 4))
  (if (pos? x)
    (assoc result 0 x)
    (assoc result 1 (- x)))
  (if (pos? y)
    (assoc result 2 y)
    (assoc result 3 (- y)))
  (print (-> result ((partial map str)) (->> (.join " ")))))

(defmain
  [&rest args]
  (solve))

#!/usr/bin/env hy

;; ----------------------------------------
;; Carmichael Numbers
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(defn prime? [n]
  (loop [[i 2]]
    (if (> (pow i 2) n)
      (!= (% n i) 1)
      (if (zero? (% n i))
        False
        (recur (inc i))))))

(defn mod-pow [x n md]
  (loop [[cn n]
         [cx x]
         [res 1]]
    (if (<= cn 0)
      res
      (do
        (when (= (& cn 1) 1)
          (setv res (% (* res cx) md)))
        (recur (>> cn 1) (% (pow cx 2) md) res)))))

(defn mod-pow2 [x n md]
  (if (zero? n)
    1
    (do
      (setv res (mod-pow2 (% (pow x 2) md) (floor (/ n 2)) md))
      (when (= (& n 1) 1)
        (setv res (% (* res x) md)))
      res)))

(defn carmicheal-number? [n]
  (if (prime? n)
    False
    (loop [[i 2]
           [flag True]]
      (if(not flag)
        False
        (if (>= i n)
          True
          (recur (inc i) (= i (mod-pow i n n))))))))
          ;(recur (inc i) (= i (mod-pow2 i n n))))))))

(defn yes-or-no [flag]
  (if flag
    (print "Yes")
    (print "No")))

(defn solve []
  (yes-or-no (carmicheal-number? 561))
  (yes-or-no (carmicheal-number? 17))
  (yes-or-no (carmicheal-number? 4)))

(defmain
  [&rest args]
  (solve))


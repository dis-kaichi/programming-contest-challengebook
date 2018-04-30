#!/usr/bin/env hy

;; ----------------------------------------
;; Cable master
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(setv data
  ["4"
   "11"
   "8.02 7.43 4.57 5.39"]) ;; 2.00

(setv +inf+ 100000000) ;; 適当

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn C [x N K L]
  (setv num 0)
  (loop [[i 0]
         [num 0]]
    (if (>= i N)
      (>= num K)
      (recur (inc i) (+ num (truncate-div (nth L i) x))))))

(defn solve []
  ;; Parameters
  (setv N (-> data first int))
  (setv K (-> data second int))
  (setv L (-> data (nth 2) (.split " ") ((partial map float)) list))
  ;; Main
  (loop [[i 0]
         [lb 0]
         [ub +inf+]]
    (if (>= i 100)
      (print (.format "{0:.2f}" (/ (floor (* ub 100)) 100)))
      (do
        (setv mid (/ (+ lb ub) 2))
        (if (C mid N K L)
          (recur (inc i) mid ub)
          (recur (inc i) lb mid))))))

(defmain
  [&rest args]
  (solve))


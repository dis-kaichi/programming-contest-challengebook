#!/usr/bin/env hy

;; ----------------------------------------
;; Aggressive cows
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["5"
   "3"
   "1 2 8 4 9"]) ;; 3

(def +inf+ 100000000) ;; 適当

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn C [d N M x]
  (loop [[i 1]
         [last 0]]
    (if (>= i M)
      True
      (do
        (setv crt (inc last))
        (while (and (< crt N)
                    (< (- (nth x crt) (nth x last)) d))
          (setv crt (inc crt)))
        (if (= crt N)
          False
          (recur (inc i) crt))))))

(defn solve []
  ;; Parameters
  (setv N (-> data first int))
  (setv M (-> data second int))
  (setv x (-> data (nth 2) (.split " ") ((partial map int)) list))
  ;; Main
  (.sort x) ;; 昇順

  (loop [[lb 0]
         [ub +inf+]]
    (if (<= (- ub lb) 1)
      (print lb)
      (do
        (setv mid (truncate-div (+ lb ub) 2))
        (if (C mid N M x)
          (recur mid ub)
          (recur lb mid))))))

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; lower_bound
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["5"
   "2 3 3 5 6"
   "3"]) ;; 1

(def data
  ["6"
   "1 2 2 3 6 7"
   "3"]) ;; 3

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv a (-> data second (.split " ") ((partial map int)) list))
  (setv k (-> data (nth 2) int))
  ;; Main
  (loop [[lb -1]
         [ub n]]
    (if (<= (- ub lb) 1)
      (print ub)
      (do
        (setv mid (truncate-div (+ lb ub) 2))
        (if (>= (nth a mid) k)
          (recur lb mid)
          (recur mid ub)))))
  )

(defmain
  [&rest args]
  (solve))


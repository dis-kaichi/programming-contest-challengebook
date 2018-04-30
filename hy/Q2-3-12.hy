#!/usr/bin/env hy

;; ----------------------------------------
;; 最長増加部分列問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(setv data
  ["5"
   "4 2 3 1 5"]) ;; 2 3 5 (3)

(setv data
  ["8"
   "4 2 3 1 5 1 6 7"]) ;; 2 3 5 6 7 (5)

(setv +n+ (-> data (nth 0) int))
(setv +a+ (-> data
             (nth 1)
             (.split " ")
             ((partial map int))
             list)) ;; iterator -> list

(setv *dp* (* [0] +n+))

(defn solve []
  (setv res 0)
  (for [i (range +n+)]
    (assoc *dp* i 1)
    (for [j (range i)]
      (when (< (nth +a+ j) (nth +a+ i))
        (assoc *dp* i (max (nth *dp* i) (inc (nth *dp* j)))))
      (setv res (max res (nth *dp* i)))))
  (print res))

(defmain
  [&rest args]
  (solve))


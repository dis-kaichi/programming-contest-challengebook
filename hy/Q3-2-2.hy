#!/usr/bin/env hy

;; ----------------------------------------
;; Subsequence (しゃくとり法Ver.)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(setv data
  ["10"
   "15"
   "5 1 4 5 10 7 4 9 2 8"]) ;; 2

(setv data
  ["5"
   "11"
   "1 2 3 4 5"]) ;; 3

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv S (-> data second int))
  (setv a (-> data (nth 2) (.split " ") ((partial map int)) list))
  ;; Main
  (loop [[res (inc n)]
         [s 0]
         [t 0]
         [sum 0]]
    (if (and (< t n) (< sum S))
      (recur res s (inc t) (+ sum (nth a t)))
      (if (< sum S)
        (do
          (when (> res n)
            (setv res 0))
          (print res))
        (recur (min res (- t s)) (inc s) t (- sum (nth a s)))))))

(defmain
  [&rest args]
  (solve))


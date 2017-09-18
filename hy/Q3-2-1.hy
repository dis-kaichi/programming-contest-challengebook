#!/usr/bin/env hy

;; ----------------------------------------
;; Subsequence
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["10"
   "15"
   "5 1 4 5 10 7 4 9 2 8"]) ;; 2

(def data
  ["5"
   "11"
   "1 2 3 4 5"]) ;; 3

(def *sum* (* [0] (int (pow 10 5))))

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn lower-bound [lower upper value]
  ;; 3-1 lower_boundのsolveを関数化したもの
  (loop [[lb lower]
         [ub upper]]
    (if (<= (- ub lb) 1)
      ub
      (do
        (setv mid (truncate-div (+ lb ub) 2))
        (if (>= (nth *sum* mid) value)
          (recur lb mid)
          (recur mid ub))))))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv S (-> data second int))
  (setv a (-> data (nth 2) (.split " ") ((partial map int)) list))
  ;; Main
  (for [i (range n)]
    (assoc *sum* (inc i) (+ (nth *sum* i) (nth a i))))
  (if (< (nth *sum* n) S)
    (print 0)
    (do
      (loop [[s 0]
             [res n]]
        (if (> (+ (nth *sum* s) S) (nth *sum* n))
          (print res)
          (do
            (setv t (lower-bound s n (+ (nth *sum* s) S)))
            (recur (inc s) (min res (- t s)))))))))

(defmain
  [&rest args]
  (solve))


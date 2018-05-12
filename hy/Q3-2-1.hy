#!/usr/bin/env hy

;; ----------------------------------------
;; Subsequence
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [lib.search [lower-bound]])

(defn parameter1 []
  ;; Answer : 2
  (setv n 10)
  (setv S 15)
  (setv a [5 1 4 5 10 7 4 9 2 8])
  (, n S a))

(defn parameter2 []
  ;; Answer : 3
  (setv n 5)
  (setv S 11)
  (setv a [1 2 3 4 5])
  (, n S a))

(setv *sum* (* [0] (int (** 10 5))))

(defn solve []
  ;; Parameters
  (setv (, n S a) (parameter1))

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
            (setv t (lower-bound *sum* (+ (nth *sum* s) S) s n))
            (recur (inc s) (min res (- t s)))))))))

(defmain
  [&rest args]
  (solve))


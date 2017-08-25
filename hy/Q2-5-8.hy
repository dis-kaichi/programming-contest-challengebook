#!/usr/bin/env hy

;; ----------------------------------------
;; 最小全域木問題１(プリム法)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["7"
   "0 1 2" ;; from to cost
   "0 2 10"
   "1 3 7"
   "1 5 3"
   "1 6 1"
   "2 3 5"
   "3 4 8"
   "3 5 1"
   "4 5 5"]) ;; cost 17

(def data
  ["8"
   "0 1 2" ;; from to cost
   "0 2 10"
   "1 3 7"
   "1 5 3"
   "1 6 1"
   "2 3 5"
   "3 4 8"
   "3 5 1"
   "4 5 5"
   "6 7 3"
   "1 7 2"]) ;; cost 19

(def +V+ (-> data first int))

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defn append-list [lst1 lst2]
  (+ lst1 [lst2]))

(def +inf+ 100000)

(defn str-data-to-matrix [vertex-info-list]
  vertex-info-list
  (loop [[matrix (create-matrix +V+ +V+ +inf+)]
         [data vertex-info-list]]
    (if (<= (len data) 0)
      matrix
      (do
        (setv (, v1 v2 cost) (-> data
                                 first
                                 (.split " ")
                                 ((partial map int))))
        (setm! matrix v1 v2 cost)
        (setm! matrix v2 v1 cost)
        (recur matrix (list (rest data)))))))

(def *cost* (-> (rest data)
                list
                str-data-to-matrix))

(def *d* (* [0] +V+))

(def *used* (* [True] +V+))

(def *min-cost* (* [0] +V+))

(defn prim []
  (for [i (range +V+)]
    (assoc *min-cost* i +inf+)
    (assoc *used* i False))
  (assoc *min-cost* 0 0)
  (loop [[res 0]]
    (setv v -1)
    (for [u (range +V+)]
      (when (and (not (nth *used* u))
                 (or (= v -1)
                     (< (nth *min-cost* u)
                        (nth *min-cost* v))))
        (setv v u)))
    (if (= v -1)
      res
      (do
        (assoc *used* v True)
        (setv res (+ res (nth *min-cost* v)))
        (for [u (range +V+)]
          (assoc *min-cost* u (min (nth *min-cost* u)
                                   (nthm *cost* v u))))
        (recur res)))))

(defn solve []
  (print (prim))
  )

(defmain
  [&rest args]
  (solve))


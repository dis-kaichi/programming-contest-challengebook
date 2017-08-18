#!/usr/bin/env hy

;; ----------------------------------------
;; 最短路問題(Dijkstra法)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["7 10"
   ;; A(0) ... G(6)
   "0 1 2" ;; from to cost
   "0 2 5"
   "1 2 4"
   "1 3 6"
   "1 4 10"
   "2 3 2"
   "3 5 1"
   "4 5 3"
   "4 6 5"
   "5 6 9"])

(def (, +V+ +E+) (-> data
                     first
                     (.split " ")
                     ((partial map int))))

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

(def *d* (* [+inf+] +V+))

(def *used* (* [False] +V+))

(defn dijkstra [s]
  (assoc *d* s 0)
  (loop []
    (setv v -1)
    (for [u (range +V+)]
      (when (and (not (nth *used* u))
                 (or (= v -1)
                     (< (nth *d* u) (nth *d* v))))
        (setv v u)))
    (when (!= v -1)
      (assoc *used* v True)
      (for [u (range +V+)]
        (assoc *d* u (min (nth *d* u)
                          (+ (nth *d* v)
                             (nthm *cost* v u)))))
      (recur))))

(defn solve []
  (dijkstra 0)
  (print *d*)) ;; 各点までのコスト

(defmain
  [&rest args]
  (solve))


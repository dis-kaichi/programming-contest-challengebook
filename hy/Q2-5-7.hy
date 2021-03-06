#!/usr/bin/env hy

;; ----------------------------------------
;; 経路復元
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(setv data
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

(setv (, +V+ +E+) (-> data
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

(setv +inf+ 100000)

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

(setv *cost* (-> (rest data)
                list
                str-data-to-matrix))

(setv *d* (* [0] +V+))

(setv *used* (* [True] +V+))

(setv *prev* (* [0] +V+)) ;; 最短路直前の頂点

(defn dijkstra [s]
  (for [i (range +V+)]
    (assoc *d* i +inf+)
    (assoc *used* i False)
    (assoc *prev* i -1))
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
        (when (> (nth *d* u)
                 (+ (nth *d* v) (nthm *cost* v u)))
          (assoc *d* u (+ (nth *d* v) (nthm *cost* v u)))
          (assoc *prev* u v)))
      (recur))))

;; 頂点tへの最短路
;; (指定した点tは含まないので注意)
(defn get-path [t]
  (loop [[index (nth *prev* t)]
         [path []]]
    (if (= index -1)
      (doto path .reverse)
      (recur (nth *prev* index) (+ path [index])))))

(defn solve []
  (dijkstra 0)
  (for [i (range +V+)]
    (print (get-path i))))

(defmain
  [&rest args]
  (solve))


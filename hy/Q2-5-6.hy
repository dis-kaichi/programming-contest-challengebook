#!/usr/bin/env hy

;; ----------------------------------------
;; 全点対最短路問題（ワーシャル-フロイド法）
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(setv data
  ["7"
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

(setv +V+ (-> data first int))

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

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

(setv *d* (-> data
             rest
             list
             str-data-to-matrix))

(defn warshall-floyd []
  (for [k (range +V+)]
    (for [i (range +V+)]
      (for [j (range +V+)]
        (setm! *d* i j
               (min (nthm *d* i j)
                    (+ (nthm *d* i k)
                       (nthm *d* k j))))))))

(defn solve []
  (warshall-floyd)
  (print *d*)) ;; 全点間のコスト

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; 分割数
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(setv data
  ["4 3 10000"]) ;; 4

(setv (, +n+ +m+ +M+) (-> data
                         (nth 0)
                         (.split " ")
                         ((partial map int))))

(defn create-matrix [n m &optional [default 0]]
  (list (map list (partition (* [default] (* n m)) m))))
(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))
(setv *dp* (create-matrix (inc +m+) (inc +n+) 0))
(setm! *dp* 0 0 1)

(defn solve []
  (for [i (range 1 (inc +m+))]
    (for [j (range (inc +n+))]
      (if (>= (- j i) 0)
        (setm! *dp* i j (% (+ (nthm *dp* (dec i) j)
                              (nthm *dp* i (- j i)))
                           +M+))
        (setm! *dp* i j (nthm *dp* (dec i) j)))))
  (print (nthm *dp* +m+ +n+)))

(defmain
  [&rest args]
  (solve))


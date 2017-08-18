#!/usr/bin/env hy

;; ----------------------------------------
;; 重複組み合わせ
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["3 3 10000"
   "1 2 3"]) ;; 6
(def (, +n+ +m+ +M+) (-> data
                         (nth 0)
                         (.split " ")
                         ((partial map int))))

(def +a+ (-> data
             (nth 1)
             (.split " ")
             ((partial map int))
             list)) ;; iterator -> list

(defn create-matrix [n m &optional [default 0]]
  (list (map list (partition (* [default] (* n m)) m))))
(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(def *dp* (create-matrix (inc +n+) (inc +m+)))

(defn solve []
  (for [i (range (inc +n+))]
    (setm! *dp* i 0 1))
  (for [i (range +n+)]
    (for [j (range 1 (inc +m+))]
      (if (>= (- j 1 (nth +a+ i)) 0)
        (setm! *dp* (inc i) j
               (% (+ (nthm *dp* (inc i) (dec j))
                     (nthm *dp* i j)
                     (- (nthm *dp* i (- j 1 (nth +a+ i))))
                     +M+)
                  +M+))
        (setm! *dp* (inc i) j
               (% (+ (nthm *dp* (inc i) (dec j))
                     (nthm *dp* i j))
                  +M+)))))
  (print (nthm *dp* +n+ +m+)))

(defmain
  [&rest args]
  (solve))


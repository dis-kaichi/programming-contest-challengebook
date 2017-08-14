#!/usr/bin/env hy

;; ----------------------------------------
;; 個数制限付き部分和問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["3 17"
   "3 5 8"
   "3 2 2"])

(def (, +n+ +K+) (-> data
                     (nth 0)
                     (.split " ")
                     ((partial map int))))
(def +a+ (-> data
             (nth 1)
             (.split " ")
             ((partial map int))
             list)) ;; iterator -> list

(def +m+ (-> data
             (nth 2)
             (.split " ")
             ((partial map int))
             list)) ;; iterator -> list

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))
(defn setm! [matrix  row col value]
  (let [x (nth matrix row)]
    (assoc x col value)))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(def *dp* (create-matrix (inc +n+) (inc +K+) False))
(setm! *dp* 0 0 True)

(defn solve []
  (for [i (range +n+)]
    (for [j (range (inc +K+))]
      (loop [[k 0]]
        (when (and (<= k (nth +m+ i))
                   (<= (* k (nth +a+ i)) j))
          (setm! *dp* (inc i) j
                 (or (nthm *dp* (inc i) j)
                     (nthm *dp* i (- j (* k (nth +a+ i))))))
          (recur (inc k))))))
  (if (nthm *dp* +n+ +K+)
    (print "Yes")
    (print "No")))

(defmain
  [&rest args]
  (solve))


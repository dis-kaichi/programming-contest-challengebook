#!/usr/bin/env hy

;; ----------------------------------------
;; 平均最大化
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["3"
   "2"
   "2 2 5 3 2 1"])

(defn split-wv [lst]
  [(list (take-nth 2 lst))
   (list (take-nth 2 (rest lst)))])

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(def +max-n+ (int (pow 10 4)))
(def +inf+ 100000000)

(defn C [x n k w v y]
  (for [i (range n)]
    (assoc y i (- (nth v i) (* x (nth w i)))))
  (.sort y)
  (loop [[i 0]
         [sum 0.0]]
    (if (>= i k)
      (>= sum 0)
      (recur (inc i) (+ sum (nth y (- n i 1)))))))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv k (-> data second int))
  (setv (, w v) (-> data
                    (nth 2)
                    (.split " ")
                    ((partial map int))
                    list
                    split-wv))
  ;; Main
  (def y (* [0] n))
  (loop [[i 0]
         [lb 0]
         [ub +inf+]]
    (if (>= i 100)
      (print (.format "{0:.2f}" ub))
      (do
        (setv mid (/ (+ lb ub) 2))
        (if (C mid n k w v y)
          (recur (inc i) mid ub)
          (recur (inc i) lb mid))))))

(defmain
  [&rest args]
  (solve))


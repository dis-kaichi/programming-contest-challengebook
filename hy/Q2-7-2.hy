#!/usr/bin/env hy

;; ----------------------------------------
;; Crazy Rows
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["2"
   "10"
   "11"]) ;; 0

(def data
  ["3"
   "001"
   "100"
   "010"]) ;; 2

(def data
  ["4"
   "1110"
   "1100"
   "1100"
   "1000"]) ;; 4

(defn nthm [matrix row col]
  (-> matrix
      (nth row)
      (nth col)))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(defn swap-array! [array i j]
  (setv ai (nth array i))
  (assoc array i (nth array j))
  (assoc array j ai))

(defn solve []
  ;; Init data
  (setv N (-> data first int))
  (setv M (-> data
              rest
              list
              ((partial map (fn [x] (-> x
                                        list                ;; split to char
                                        ((partial map int)) ;; char to int
                                        list))))            ;; iterator to list
              list))
  (setv a (* [0] N))
  ;; Solve Main
  (setv res 0)
  (for [i (range N)]
    (do
      (assoc a i -1)
      (for [j (range N)]
        (when (= 1 (nthm M i j))
          (assoc a i j)))))
  (for [i (range N)]
    (do
      (setv pos -1)
      (for [j (range i N)]
        (when (<= (nth a j) i)
          (setv pos j)
          (break)))
      ;; Swap
      (for [j (range pos i -1)]
        (do
          (swap-array! a j (dec j))
          (setv res (inc res))))))
  (print res))

(defmain
  [&rest args]
  (solve))


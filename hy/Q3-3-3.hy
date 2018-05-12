#!/usr/bin/env hy

;; ----------------------------------------
;; バブルソートの交換回数
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [lib.bit [sum add]])

(setv data
  ["4"
   "3 1 4 2"]) ;; 3

(defn map-int [xs] (list (map int xs)))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv a (-> data second (.split " ") map-int))
  ;; Main
  (setv ans 0)
  (for [j (range n)]
    (setv ans (+ ans (- j (sum (nth a j)))))
    (add n (nth a j) 1))
  (print ans)
  )


(defmain
  [&rest args]
  (solve))


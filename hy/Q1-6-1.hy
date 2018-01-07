#!/usr/bin/env hy

;; ----------------------------------------
;; 三角形
;; ----------------------------------------
(import [lib.inpututils [split-with-space map-int]])

(defn solver [data]
  ;; Parameter
  (setv n (-> data first int))
  (setv a (-> data second split-with-space map-int))
  ;; Main
  (setv ans 0)
  (for [i (range n)]
    (for [j (range (inc i) n)]
      (for [k (range (inc j) n)]
        (setv ai (nth a i))
        (setv aj (nth a j))
        (setv ak (nth a k))
        (setv len (sum [ai aj ak]))
        (setv ma (max [ai aj ak]))
        (setv res (- len ma))
        (when (< ma res)
          (setv ans (max ans len))))))
  ans)

(defn solve []
  ;; Data
  (setv data1
        ["5"
         "2 3 4 5 10"]) ;; 12
  (setv data2
        ["4"
         "4 5 10 20"])  ;; 0
  ;; Example1
  (print "Example1 : " (solver data1))
  ;; Example2
  (print "Example2 : " (solver data2)))

(defmain
  [&rest args]
  (solve))


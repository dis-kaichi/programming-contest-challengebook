#!/usr/bin/env hy

;; ----------------------------------------
;; 部分和問題
;; ----------------------------------------

(import [lib.inpututils [split-with-space map-int]])

(defn dfs [n a k i ss]
  (if (= i n)
    (= ss k)
    (if (dfs n a k (inc i) ss)
      True
      (if (dfs n a k (inc i) (+ ss (nth a i)))
        True
        False))))

(defn solver [data]
  ;; Parameter
  (setv n (-> data first int))
  (setv a (-> data second split-with-space map-int))
  (setv k (-> data (nth 2) int))
  ;; Main
  (if (dfs n a k 0 0)
    "Yes"
    "No"))

(defn solve []
  (setv data1
        ["4"
         "1 2 4 7"
         "13"]) ;; "Yes"
  (setv data2
        ["4"
         "1 2 4 7"
         "15"]) ;; "No"
  (print "Example1 : " (solver data1))
  (print "Example2 : " (solver data2))
  )

(defmain
  [&rest args]
  (solve))


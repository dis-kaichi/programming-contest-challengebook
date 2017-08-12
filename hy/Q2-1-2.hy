#!/usr/bin/env hy

;; ----------------------------------------
;; 部分和問題
;; ----------------------------------------

(def data
  ["4"
   "1 2 4 7"
   "13"])
;;(def data
;;  ["4"
;;   "1 2 4 7"
;;   "15"])

(def +N+ (int (nth data 0)))
(def +A+ (list (map int (.split (nth data 1)))))
(def +K+ (int (nth data 2)))

(defn dfs [i ss]
  (if (= i +N+)
    (= ss +K+)
    (if (dfs (inc i) ss)
      True
      (if (dfs (inc i) (+ ss (nth +A+ i)))
        True
        False))))

(defn solve []
  (if (dfs 0 0)
    (print "Yes")
    (print "No"))
  )

(defmain
  [&rest args]
  (solve))


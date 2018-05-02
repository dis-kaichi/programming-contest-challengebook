#!/usr/bin/env hy

;; ----------------------------------------
;; Beauty Contest (グラハムスキャン)
;; ----------------------------------------

(import [lib.point [Point]])
(import [lib.convex [convex-hull]])

(defn list-to-point [xs]
  (Point #* xs))

(defn lists-to-points [xs]
  (list (map list-to-point xs)))

(defn parameter1 []
  ;; Answer : 80 ((1,8)と(5,0))
  (setv N 8)
  (setv ps (-> [[0 5]
                [1 8]
                [3 4]
                [5 0]
                [6 2]
                [6 6]
                [8 3]
                [8 7]]
               lists-to-points))
  (, N ps))

;; 距離の2乗
(defn dist [p q]
  (.dot (- p q)
        (- p q)))

(defn solve []
  ;; Parameters
  (setv (, N ps) (parameter1))

  ;; Main
  (setv qs (convex-hull ps N))
  (setv res 0)
  (for [i (range (len qs))]
    (for [j (range i)]
      (setv res (max res (dist (get qs i) (get qs j))))))
  (print (.format "{0:.0f}" res)))


(defmain
  [&rest args]
  (solve))

#!/usr/bin/env hy

;; ----------------------------------------
;; 最小コスト通信
;; ----------------------------------------
(import [lib.mincost [min-cost-flow add-edge]])
(import [lib.operations [safe-get]])

(defn solve []
  ;; Parameters
  (setv (, V F) (, 5 9))
  (setv capacity
       [[0 10 2 0 0]
        [0 0 6 6 0]
        [0 0 0 0 5]
        [0 0 3 0 8]
        [0 0 0 0 0]])
  (setv cost
        [[0 2 4 0 0]
         [0 0 6 2 0]
         [0 0 0 0 2]
         [0 0 3 0 6]
         [0 0 0 0 0]])
  ;; Main
  (setv s 0)
  (setv t (dec V))
  (for [row (range V)]
    (for [col (range V)]
      (add-edge row col (get capacity row col) (get cost row col))))
  (print (min-cost-flow V s t F)))

(defmain
  [&rest args]
  (solve))


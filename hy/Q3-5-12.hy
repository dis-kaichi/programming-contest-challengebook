#!/usr/bin/env hy

;; ----------------------------------------
;; Farm Tour
;; ----------------------------------------
(import [lib.mincost [add-edge min-cost-flow]])
(import [lib.matrix [transpose]])

(defn parameter1 []
  ;; Answer : 6 (1 -> 2 -> 4 -> 3 -> 1)
  (setv (, N M) (, 4 5))
  (setv (, a b c) (-> [[1 2 1]
                       [2 3 1]
                       [3 4 1]
                       [1 3 2]
                       [2 4 2]]
                      transpose))
  (, N M a b c))

(defn solve []
  ;; Paramters
  (setv (, N M a b c) (parameter1))

  ;; Main

  ;; グラフを作成
  (setv s 0)
  (setv t (dec N))

  (setv V N)
  (for [i (range M)]
    (add-edge (dec (get a i)) (dec (get b i)) 1 (get c i))
    (add-edge (dec (get b i)) (dec (get a i)) 1 (get c i)))

  (print (min-cost-flow V s t 2)))

(defmain
  [&rest args]
  (solve))


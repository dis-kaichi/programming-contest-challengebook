#!/usr/bin/env hy

;; ----------------------------------------
;; Stock Charts
;; ----------------------------------------

(import [lib.bipartite [bipartite-matching add-edge clear-graph]])

(defn seats-to-values [seats]
  (list (map list seats)))

(defn parameter1 []
  ;; Answer : 2 (3つ目と5つ目、及びそれ以外を1つの図に入れられる)
  (setv (, n k) (, 5 2))
  (setv price  [[1 1]
                [2 2]
                [5 4]
                [4 4]
                [4 1]])
  (, n k price))

(defn solve []
  ;; Parameters
  (setv (, N K P) (parameter1))

  ;; Main
  (setv V (* N 2))
  (clear-graph)

  (for [i (range N)]
    (for [j (range N)]
      (when (= i j)
        (continue))
      (setv f True)
      (for [k (range K)]
        (when (>= (get P j k) (get P i k))
          (setv f False)))
      (when f
        (add-edge i (+ N j)))))

  (setv ans (- N (bipartite-matching V)))
  (print ans))

(defmain
  [&rest args]
  (solve))


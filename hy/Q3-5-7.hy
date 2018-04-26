#!/usr/bin/env hy

;; ----------------------------------------
;; Asteroids
;; ----------------------------------------
(import [lib.bipartite [bipartite-matching add-edge]])
(import [lib.inpututils [split-with-space map-int]])

(defn solve []
  ;; Parameters

  ;; Ans : 2
  ;;       [1] (1, 1) (1, 3)
  ;;       [2] (2, 2) (3, 2)
  (setv (, N K) (, 3 4))
  (setv (, R C) (-> "1 1 1 3 2 2 3 2"
                   split-with-space
                   map-int
                   ((fn [x] (, (list (take-nth 2 x))
                               (list (take-nth 2 (rest x))))))))

  (setv V (* N 2))
  (for [i (range K)]
    (add-edge (dec (nth R i))
              (+ N (dec (nth C i)))))

  (print (bipartite-matching V))
  )

(defmain
  [&rest args]
  (solve))


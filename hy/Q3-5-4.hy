#!/usr/bin/env hy

;; ----------------------------------------
;; 仕事の割り当て２
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [lib.inpututils [split-with-space map-int]])
(import [lib.operations [safe-get conj]])
(import [lib.bipartite [bipartite-matching add-edge]])

(setv data
  ["3 3" ;; N K(N : uの部分, K : vの部分)
   "1 1 0" ;; 1 : uとvに関連がある, 0 : ない
   "1 0 1"
   "0 1 0"
   ])

(defn solve []
  ;; Parameters
  (setv (, N K) (-> data first split-with-space map-int))
  (setv matrix (-> data
                   rest
                   ((fn [x] (map (comp map-int split-with-space) x)))
                   list))

  ;; Main
  (for [row (range (len matrix))]
    (for [col (range (len (safe-get matrix 0 [])))]
      (when (not (zero? (get matrix row col)))
        (add-edge row (+ col N)))))

  (print (bipartite-matching (+ N K))))

(defmain
  [&rest args]
  (solve))

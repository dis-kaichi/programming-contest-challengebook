#!/usr/bin/env hy

;; ----------------------------------------
;; 最大通信量
;; ----------------------------------------

(import [lib.operations [safe-get]])
(import [lib.fordfullkerson [max-flow add-edge]])

(defn solve []
  (setv matrix
       [[0 10 2 0 0]
        [0 0 6 6 0]
        [0 0 0 0 5]
        [0 0 3 0 8]
        [0 0 0 0 0]])
  (for [row (range (len matrix))]
    (for [col (range (len (safe-get matrix 0 [])))]
      (add-edge row col (get matrix row col))))
  (print (max-flow 0 4)))

(defmain
  [&rest args]
  (solve))


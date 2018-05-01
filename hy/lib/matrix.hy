#!/usr/bin/env hy

;; ----------------------------------------
;; Utility for matrix
;; ----------------------------------------
(require[hy.extra.anaphoric [ap-pipe]])

;; Functions

;; Get an element of matrix.
;;  matrix[row][col]
;;  => (get matrix row col)

;; Set a value to the matrix
;;  matrix[row][col] = 100
;;  => (assoc (get matrix row) col 100)

;; Transpose of matrix
;; (transpose [[1 2] [3 4]])
;;  => [[1 3] [2 4]]
(defn transpose [matrix]
  (list (map list (zip #* matrix))))

(defn create-matrix [n m &optional [default 0]]
  (ap-pipe (* [default] (* n m))
           (partition it m)
           (map list it)
           (list it)))



;; Macros


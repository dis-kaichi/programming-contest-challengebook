#!/usr/bin/env hy

;; ----------------------------------------
;; Utility for matrix
;; ----------------------------------------

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
  (list (map list (apply zip matrix))))

;; Macros


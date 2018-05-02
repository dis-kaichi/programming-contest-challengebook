#!/usr/bin/env hy

;; ----------------------------------------
;; Utility for matrix
;; ----------------------------------------
(require[hy.extra.anaphoric [ap-pipe]])
(import sys)

;; Constants
(setv *mod* (. sys maxsize))

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

;; 環境変数変更
(defn set-mod [n]
  (global *mod*)
  (setv *mod* n))

;; A^n : 繰り返し２乗法
(defn mod-pow [A n]
  (setv order (len A))
  (setv B (create-matrix order order 0))
  (for [i (range order)]
    (assoc (get B i) i 1))
    ;(setm! B i i 1))
  (while (> n 0)
    (when (& n 1)
      (setv B (mul B A)))
    (setv A (mul A A))
    (setv n (>> n 1)))
  B)

;; A * B
(defn mul [A B]
  (setv C (create-matrix (len A) (len (nth B 0)) 0))
  (for [i (range (len A))]
    (for [k (range (len B))]
      (for [j (range (len (nth B 0)))]
        (assoc (get C i) j (% (+ (get C i j)
                                 (* (get A i k) (get B k j)))
                        *mod*)))))
  C)



;; Macros


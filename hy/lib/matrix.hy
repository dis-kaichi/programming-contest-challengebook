#!/usr/bin/env hy

;; ----------------------------------------
;; Utility for matrix
;; ----------------------------------------
(require[hy.extra.anaphoric [ap-pipe]])
(import sys)

;; Constants
(setv +eps+ (** 10 -8))
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
      (setv B (mul-pow B A)))
    (setv A (mul-pow A A))
    (setv n (>> n 1)))
  B)

;; A * B
(defn mul-pow [A B]
  (setv C (create-matrix (len A) (len (nth B 0)) 0))
  (for [i (range (len A))]
    (for [k (range (len B))]
      (for [j (range (len (nth B 0)))]
        (assoc (get C i) j (% (+ (get C i j)
                                 (* (get A i k) (get B k j)))
                        *mod*)))))
  C)

;; Gauss-Jordanの消去法
;;    Ax = bを解く、Aは正方行列
;;    解がないか一意で無い場合は長さ0の配列を返す
(defn gauss-jordan [A b]
  (setv n (len A))
  (setv B (create-matrix n (inc n)))
  (for [i (range n)]
    (for [j (range n)]
      (assoc (get B i) j (get A i j))))
  ;; 行列Aの後ろにbを並べて同時に処理する
  (for [i (range n)]
    (assoc (get B i) n (get b i)))

  (for [i (range n)]
    ;; 注目している変数の係数の絶対値が大きい式を1番目に持ってくる
    (setv pivot i)
    (for [j (range i n)]
      (when (> (abs (get B j i)) (abs (get B pivot i)))
        (setv pivot j)))
    ;; Swap
    (setv tmp (get B i))
    (assoc B i (get B pivot))
    (assoc B pivot tmp)

    ;; 解がないか、一意でない
    (for [j (range (inc i) (inc n))]
      (assoc (get B i) j (/ (get B i j) (get B i i))))
    (for [j (range n)]
      (when (!= i j)
        ;; j番目の式からi番目の変数を消去
        (for [k (range (inc i) (inc n))]
          (assoc (get B j) k (- (get B j k) (* (get B j i) (get B i k))))))))
  ;; 後ろに並べたbが解になる
  (setv x [])
  (for [i (range n)]
    (.append x (get B i n)))
  x)

;; Macros


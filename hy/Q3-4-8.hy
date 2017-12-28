#!/usr/bin/env hy

;; ----------------------------------------
;; グラフの長さkのパスの総数
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(require[hy.extra.anaphoric [ap-pipe]])

(def data
  [
   "4 2" ;; 
   "0 1 1 0"
   "0 0 1 0"
   "0 0 0 1"
   "1 0 0 0"
   ])

(def +m+ 10007)

(defn nthm [matrix row col]
  (-> matrix
      (nth row)
      (nth col)))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(defn create-matrix [n m &optional [default 0]]
  (ap-pipe (* [default] (* n m))
           (partition it m)
           (map list it)
           (list it)))

;; A * B
(defn mul [A B]
  (setv C (create-matrix (len A) (len (nth B 0)) 0))
  (for [i (range (len A))]
    (for [k (range (len B))]
      (for [j (range (len (nth B 0)))]
        (setm! C i j (% (+ (nthm C i j)
                           (* (nthm A i k) (nthm B k j)))
                        +m+)))))
  C)

;; A^n
(defn pow [A n]
  (setv order (len A))
  (setv B (create-matrix order order 0))
  (for [i (range order)]
    (setm! B i i 1))
  (while (> n 0)
    (when (& n 1)
      (setv B (mul B A)))
    (setv A (mul A A))
    (setv n (>> n 1)))
  B)

(defn convert-matrix [lines]
  (setv matrix [])
  (for [line lines]
    (.append matrix (-> line (.split " ") ((fn [x] (map int x))) list)))
  matrix)

(defmacro += [variable value]
  `(setv ~variable (+ ~variable ~value)))

(defn solve []
  ;; Parameters
  (setv (, n k) (-> data first (.split " ") ((fn [x] (map int x)))))
  (setv G1 (-> data rest convert-matrix))
  ;; Main
  (setv num-of-paths 0)
  (for [row (pow G1 k)]
    (+= num-of-paths (sum row)))
  (print num-of-paths)
  )

(defmain
  [&rest args]
  (solve))

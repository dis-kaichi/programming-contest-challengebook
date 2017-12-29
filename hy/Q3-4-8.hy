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
   ]) ;; 6

(def +m+ 10007)

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
        (setv (get C i j) (% (+ (get C i j)
                                (* (get A i k) (get B k j)))
                             +m+)))))
  C)

;; A^n
(defn pow [A n]
  (setv order (len A))
  (setv B (create-matrix order order 0))
  (for [i (range order)]
    (setv (get B i i) 1))
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

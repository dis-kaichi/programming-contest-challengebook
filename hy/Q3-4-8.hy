#!/usr/bin/env hy

;; ----------------------------------------
;; グラフの長さkのパスの総数
;; ----------------------------------------

(import [lib.matrix [set-mod mod-pow]])

(setv data
  [
   "4 2" ;; 
   "0 1 1 0"
   "0 0 1 0"
   "0 0 0 1"
   "1 0 0 0"
   ]) ;; 6

(setv +m+ 10007)

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
  (set-mod +m+)
  (setv num-of-paths 0)
  (for [row (mod-pow G1 k)]
    (+= num-of-paths (sum row)))
  (print num-of-paths)
  )

(defmain
  [&rest args]
  (solve))

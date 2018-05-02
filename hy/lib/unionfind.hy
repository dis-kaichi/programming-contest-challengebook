#!/usr/bin/env hy

;; ----------------------------------------
;; Union-Find木
;; ----------------------------------------
(setv +union-find-max+ 10000)
(setv *parent* (* [0] +union-find-max+))
(setv *rank* (* [0] +union-find-max+))

(defn init-union-find [n]
  (for [i (range n)]
    (assoc *parent* i i)
    (assoc *rank* i 0)))

(defn find [x]
  (if (= (nth *parent* x) x)
    x
    (do
      (assoc *parent* x (find (nth *parent* x)))
      (nth *parent* x))))

(defn unite [x y]
  (setv x (find x))
  (setv y (find y))
  (when (not (= x y))
    (if (< (nth *rank* x) (nth *rank* y))
      (assoc *parent* x y)
      (do
        (assoc *parent* y x)
        (when (= (nth *rank* x) (nth *rank* y))
          (assoc *rank* x (inc (nth *rank* x))))))))

(defn same [x y]
  (= (find x) (find y)))

(defn get-parent []
  *parent*)

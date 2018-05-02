#!/usr/bin/env hy

;; ----------------------------------------
;; Blocks
;; ----------------------------------------

(import [lib.matrix [mod-pow set-mod]])

(defn parameter1 []
  ;; Answer : 2
  (setv N 1)
  (, N))

(defn parameter2 []
  ;; Answer : 6
  (setv N 2)
  (, N))

(setv +m+ 10007)

(defn solve []
  ;; Parameters
  (setv (, N) (parameter2))
  ;; Main
  (set-mod +m+)
  (setv A [[2 1 0] [2 2 2] [0 1 2]])
  (setv A (mod-pow A N))
  (print (get A 0 0))
  )

(defmain
  [&rest args]
  (solve))


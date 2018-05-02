#!/usr/bin/env hy

;; ----------------------------------------
;; フィボナッチ数列
;; ----------------------------------------

(import [lib.matrix [mod-pow set-mod]])

(setv data
  ["10"])

(defn create-matrix [n m &optional [default 0]]
  (ap-pipe (* [default] (* n m))
           (partition it m)
           (map list it)
           (list it)))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))

  ;; Main
  (set-mod 10000)
  (setv A [[1 1] [1 0]])
  (setv A (mod-pow A n))
  (print (get A 1 0)))

(defmain
  [&rest args]
  (solve))


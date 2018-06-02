#!/usr/bin/env hy

;; ----------------------------------------
;; 三角形
;; ----------------------------------------
(import [lib.inpututils [split-with-space map-int]])

(defn parameter1 []
  ;; Answer : 12
  (setv N 5)
  (setv A [2 3 4 5 10])
  (, N A))

(defn parameter2 []
  ;; Answer : 0
  (setv N 4)
  (setv A [4 5 10 20])
  (, N A))

(defn solver [n a]
  (setv ans 0)
  (for [i (range n)]
    (for [j (range (inc i) n)]
      (for [k (range (inc j) n)]
        (setv ai (nth a i))
        (setv aj (nth a j))
        (setv ak (nth a k))
        (setv len (sum [ai aj ak]))
        (setv ma (max [ai aj ak]))
        (setv res (- len ma))
        (when (< ma res)
          (setv ans (max ans len))))))
  ans)

(defn solve []
  ;; Parameters
  (setv (, N A) (parameter1))
  ;; Main
  (print (solver N A)))

(defmain
  [&rest args]
  (solve))


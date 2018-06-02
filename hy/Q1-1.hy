#!/usr/bin/env hy

;; ----------------------------------------
;; くじびき
;; ----------------------------------------
(import [lib.inpututils [split-with-space map-int]])

(defn parameter1 []
  ;; Answer :: Yes
  (setv N 3)
  (setv M 10)
  (setv K [1 3 4])
  (, N M K))

(defn parameter2 []
  ;; Answer :: No
  (setv N 3)
  (setv M 9)
  (setv K [1 3 5])
  (, N M K))

(defn solver [n m k]
  (setv f False)
  (for [x1 (range n)]
    (for [x2 (range n)]
      (for [x3 (range n)]
        (for [x4 (range n)]
          (when (= (sum [(nth k x1)
                         (nth k x2)
                         (nth k x3)
                         (nth k x4)
                         ])
                   m)
            (setv f True))))))
  (if f
    "Yes"
    "No"))

(defn solve []
  ;; Parameters
  (setv (, N M K) (parameter1))
  ;; Main
  (print (solver N M K)))

(defmain
  [&rest args]
  (solve))


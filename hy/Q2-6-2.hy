#!/usr/bin/env hy

;; ----------------------------------------
;; 双六
;; ----------------------------------------
(import [functools [partial]])
(import [lib.algebra [extgcd]])
(import [lib.operations [cmap]])

(defn parameter1 []
  ;; Answer : 3 0 0 1
  (setv (, a b) (, 4 11))
  (, a b))

(defn solve []
  ;; Parameters
  (setv (, a b) (parameter1))

  ;; Main
  (setv (, x y d) (extgcd a b))
  (setv result (* [0] 4))
  (if (pos? x)
    (assoc result 0 x)
    (assoc result 1 (- x)))
  (if (pos? y)
    (assoc result 2 y)
    (assoc result 3 (- y)))
  (print (-> result ((cmap str)) (->> (.join " ")))))

(defmain
  [&rest args]
  (solve))

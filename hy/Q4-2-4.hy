#!/usr/bin/env hy

;; ----------------------------------------
;; Nim
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : Alice
  (setv n 3)
  (setv a [1 2 4])
  (, n a))

(defn parameter2 []
  ;; Answer : Bob
  (setv n 3)
  (setv a [1 2 3])
  (, n a))

(defn solve []
  ;; Parameters
  (setv (, N A) (parameter1))

  ;; Main
  (setv x 0)
  (for [i (range N)]
    (^= x (get A i)))

  (if (!= x 0)
    (print "Alice")
    (print "Bob")))

(defmain
  [&rest args]
  (solve))

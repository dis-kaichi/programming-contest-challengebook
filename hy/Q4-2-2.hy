#!/usr/bin/env hy

;; ----------------------------------------
;; A Funny Game
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : Alice
  (setv n 1)
  (, n))

(defn parameter2 []
  ;; Answer : Bob
  (setv n 3)
  (, n))

(defn solve []
  ;; Parameters
  (setv (, n) (parameter1))

  ;; Main
  (if (<= n 2)
    (print "Alice")
    (print "Bob")))

(defmain
  [&rest args]
  (solve))

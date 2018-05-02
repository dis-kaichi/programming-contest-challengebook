#!/usr/bin/env hy

;; ----------------------------------------
;; 素数の個数（エラトステネスの篩）
;; ----------------------------------------
(import [lib.eratosthenes [sieve]])

(defn parameter1 []
  ;; Answer : 5
  (setv n 11)
  (, n))

(defn parameter2 []
  ;; Answer : 78498
  (setv n 1000000)
  (, n))

(defn solve []
  ;; Parametes
  (setv (, n) (parameter2))

  ;; Main
  (print (sieve n)))

(defmain
  [&rest args]
  (solve))

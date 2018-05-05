#!/usr/bin/env hy

;; ----------------------------------------
;; Georgia and Bob
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : Bob will win
  (setv n 3)
  (setv p [1 2 3])
  (, n p))

(defn parameter2 []
  ;; Answer : Georgia will win
  (setv n 8)
  (setv p [1 5 6 7 9 12 14 17])
  (, n p))

(defn solve []
  ;; Parameters
  (setv (, N P) (parameter2))

  ;; Main
  (when (odd? N)
    ;(assoc P N 0)
    (.append P 0)
    (+= N 1))
  (.sort P)

  (setv x 0)
  (for [i (range 0 (dec N) 2)]
    (^= x (- (get P (inc i)) (get P i) 1)))

  (if (zero? x)
    (print "Bob will win")
    (print "Georgia will win")))


(defmain
  [&rest args]
  (solve))

#!/usr/bin/env hy

;; ----------------------------------------
;; 石の塗り方の数え上げ　
;; ----------------------------------------

(import [lib.algebra [prime-factor divisor mod-pow]])

(defn parameter1 []
  ;; Answer : 55
  (setv (, n m) (, 2 10))
  (, n m))

(defn parameter2 []
  ;; Answer : 2530
  (setv (, n m) (, 4 10))
  (, n m))

(defn parameter3 []
  ;; Answer : 6
  (setv (, n m) (, 4 2))
  (, n m))

(defn parameter4 []
  ;; Answer : 898487047
  (setv (, n m) (, 1000000000 1000000000))
  (, n m))

(setv +mod+ 1000000007)

(defn solve []
  ;; Parameters
  (setv (, n m) (parameter1))

  ;; Main
  (import sys)
  (setv primes (prime-factor n))
  (setv divs (divisor n))
  (setv res 0)

  (for [i (range (len divs))]
    ;; オイラー関数のdivs[i]での値を求める
    (setv euler (get divs i))
    (for [it (.items primes)]
      (setv p (first it))
      (when (zero? (% (get divs i) p))
        (setv euler (* (// euler p) (dec p)))))
    (+= res (% (* euler (mod-pow m (// n (get divs i)) +mod+)) +mod+))
    (%= res +mod+))

  ;; 最後にnで割る
  (print (% (* res (mod-pow n (- +mod+ 2) +mod+)) +mod+)))

(defmain
  [&rest args]
  (solve))

#!/usr/bin/env hy

;; ----------------------------------------
;; 線分上の格子点の個数
;; ----------------------------------------
(import [functools [partial]])
(import [lib.algebra [gcd]])

(setv data
  ["1 11" ;; P1
   "5 3"  ;; P2
   ])

(defclass Point []
  [_x 0
   _y 0]
  (defn --init-- [self x y]
    (setv (. self _x) x)
    (setv (. self _y) y))
  #@(property (defn x[self]))
  #@(x.setter (defn x[self x] (setv (. self _x) x)))
  #@(x.getter (defn x[self] (. self _x)))
  #@(property (defn y[self]))
  #@(y.setter (defn y[self y] (setv (. self _y) y)))
  #@(y.getter (defn y[self] (. self _y)))
  (defn to-list [self]
    [(. self x) (. self y)])
  (defn --str-- [self] (.format "{0} {1}" (. self x) (. self y))))

(defn of-point [xs]
  (Point #* xs))

(defn solve []
  (setv p1 (-> data
               first
               (.split " ")
               ((partial map int))
               of-point))
  (setv p2 (-> data
               second
               (.split " ")
               ((partial map int))
               of-point))
  (setv dx (abs (- (. p1 x) (. p2 x))))
  (setv dy (abs (- (. p1 y) (. p2 y))))
  (print (dec (gcd dx dy))) ;; Answer
  )

(defmain
  [&rest args]
  (solve))


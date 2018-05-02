#!/usr/bin/env hy

;; ----------------------------------------
;; Numbers
;; ----------------------------------------

(import [lib.matrix [mod-pow set-mod]])
(setv +mod+ 1000)

(defn parameter1 []
  ;; Answer : 027 ((3+sqrt(5))^2)
  (setv n 2)
  (, n))

(defn parameter2 []
  ;; Answer : 935 ((3+sqrt(5))^5)
  (setv n 5)
  (, n))

(defn solve []
  ;; Parameters
  (setv (, n) (parameter2))

  ;; Main
  (set-mod +mod+)
  (setv A [[3 5]
           [1 3]])
  (setv A (mod-pow A n))
  (print (.format "{0:03}" (% (+ (* (get A 0 0) 2) (dec +mod+)) +mod+))))

(defmain
  [&rest args]
  (solve))


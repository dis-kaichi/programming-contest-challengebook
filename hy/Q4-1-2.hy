#!/usr/bin/env hy

;; ----------------------------------------
;; 包除原理
;; ----------------------------------------

(import [lib.algebra [gcd]])

(defn parameter1 []
  ;; Answer : 67
  (setv (, n m) (, 100 2))
  (setv a [2 3])
  (, n m a))

(defn parameter2 []
  ;; Answer : 72
  (setv (, n m) (, 100 3))
  (setv a [2 3 7])
  (, n m a))

(defn solve []
  ;; Parameters
  (setv (, n m a) (parameter1))

  ;; Main
  (setv res 0)
  (for [i (range 1 (<< 1 m))]
    (setv num 0)
    (setv j i)
    (while (not (zero? j))
      (+= num (& j 1))
      (>>= j 1))
    (setv lcm 1)
    (for [j (range m)]
      (when (& (>> i j) 1)
        (setv lcm (* (// lcm (gcd lcm (get a j))) (get a j)))
        ;; lcmがnを超えるとn/lcm=0なので、オーバーフローする前にbreakする
        (when (> lcm n)
          (break))))
    (if (even? num)
      (-= res (// n lcm))
      (+= res (// n lcm))))
  (print res))

(defmain
  [&rest args]
  (solve))

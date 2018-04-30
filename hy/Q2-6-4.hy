#!/usr/bin/env hy

;; ----------------------------------------
;; 素数の個数（エラトステネスの篩）
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(setv +max-n+ 1000000)
(setv *prime* (* [False] +max-n+))
(setv *is-prime* (* [False] (inc +max-n+)))

(defn sieve [n]
  (setv p 0)
  (for [i (range (inc n))]
    (assoc *is-prime* i True))
  (assoc *is-prime* 0 False)
  (assoc *is-prime* 1 False)
  (for [i (range 2 (inc n))]
    (when (nth *is-prime* i)
      (assoc *prime* p i)
      (setv p (inc p))
      (for [j (range (* 2 i) (inc n) i)]
        (assoc *is-prime* j False))))
  p)

(defn solve []
  (print (sieve 11))
  ;;(print (sieve 1000000)) ;; too slow
  )

(defmain
  [&rest args]
  (solve))

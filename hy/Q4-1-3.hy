#!/usr/bin/env hy

;; ----------------------------------------
;; 周期的でない文字列の数え上げ
;; ----------------------------------------

(import [lib.algebra [gcd mod-pow]])

(defn parameter1 []
  ;; Answer : 650
  (setv n 2)
  (, n))

(defn parameter2 []
  ;; Answer : 5895
  (setv n 4)
  (, n))

(defn parameter3 []
  ;; Answer : 334
  (setv n 15315300)
  (, n))

;; nの約数におけるメビウス関数の値のmapを返す
(defn moebius [n]
  (setv res {})
  (setv primes [])

  ;; nの素因数を列挙する
  (setv i 2)
  (while (<= (** i 2) n)
    (when (zero? (% n i))
      (.append primes i)
      (while (zero? (% n i))
        (//= n i)))
    (+= i 1))

  (when (!= n 1)
    (.append primes n))

  (setv m (len primes))
  (for [i (range (<< 1 m))] ;; 2^m通り回るが、nの約数の個数より小さい
    (setv (, mu d) (, 1 1))
    (for [j (range m)]
      (when (& (>> i j) 1)
        (*= mu -1)
        (*= d (get primes j))))
    (assoc res d mu))
  res)

(setv +mod+ 10009)

(defn solve []
  ;; Parameters
  (setv (, n) (parameter3))

  ;; Main
  (setv res 0)
  (setv mu (moebius n))
  (for [it (.items mu)]
    (+= res (* (second it) (mod-pow 26 (// n (first it)) +mod+)))
    (setv res (% (+ (% res +mod+) +mod+) +mod+)))
  (print res))

(defmain
  [&rest args]
  (solve))

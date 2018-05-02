#!/usr/bin/env hy

;; ----------------------------------------
;; Number Sets
;; ----------------------------------------

(import [lib.unionfind [init-union-find unite find]])
(import [lib.eratosthenes [sieve get-prime]])

(defn parameter1 []
  ;; Answer : 9
  (setv (, A B P) (, 10 20 5))
  (, A B P))

(defn parameter2 []
  ;; Answer : 7
  (setv (, A B P) (, 10 20 3))
  (, A B P))

(defn solve []
  ;; Parameters
  (setv (, A B P) (parameter1))

  ;; Main
  (setv p (sieve 1000000))
  (setv prime (get-prime))

  (setv size (+ B (- A) 1))
  (init-union-find size)    ;; Union-Findの初期化

  (for [i (range p)]
    ;; P以上の素数に対して処理する
    (when (>= (get prime i) P)
      ;; A以上の最小のprime[i]の倍数
      (setv start (* (// (+ A (get prime i) -1) (get prime i)) (get prime i)))
      ;; B以下の最大のprime[i]の倍数
      (setv end (* (// B (get prime i)) (get prime i)))

      (for [j (range start (inc end) (get prime i))]
        ;; startとjは同じ集合に属する
        (unite (- start A) (- j A)))))

  (setv res 0)
  (for [i (range A (inc B))]
    ;; find(i) == iの時はiはUnion-Findの根になっている
    ;; 根の個数は集合の個数と一致する
    (when (= (find (- i A)) (- i A))
      (+= res 1)))
  (print res))

(defmain
  [&rest args]
  (solve))


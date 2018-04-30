#!/usr/bin/env hy

;; ----------------------------------------
;; Dual Core
;; ----------------------------------------
(import [lib.dinic [add-edge max-flow]])
(import [lib.matrix [transpose]])

(defn parameter1 []
  (setv (, N M) (, 3 1))
  (setv (, A B) (-> [[1 10]
                     [2 10]
                     [10 3]]
                    transpose))
  (setv (, a b w) (-> [[2 3 1000]]
                      transpose))
  (, N M A B a b w))

(defn solve []
  ;; Paramters
  (setv (, N M A B a b w) (parameter1))

  ;; Main
  (setv s N)
  (setv t (inc s))

  ;; 各コアで実行する際に生じるコスト
  (for [i (range N)]
    (add-edge i t (get A i))
    (add-edge s i (get B i)))

  ;; 異なるコアで実行する際に生じるコスト
  (for [i (range M)]
    (add-edge (dec (get a i)) (dec (get b i)) (get w i))
    (add-edge (dec (get b i)) (dec (get a i)) (get w i)))

  (print (max-flow s t)))


(defmain
  [&rest args]
  (solve))


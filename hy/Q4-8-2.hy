#!/usr/bin/env hy

;; ----------------------------------------
;; Year of More Code Jam
;; ----------------------------------------
(import [lib.operations [safe-get]])
(import [lib.algebra [gcd]])

(defn parameter1 []
  ;; Answer : 1+0/1
  (setv N 1)
  (setv T 1)
  (setv m [2])
  (setv d [[1 2]])
  (, N T m d))

(defn parameter2 []
  ;; Answer : 5+1/8
  (setv N 4)
  (setv T 2)
  (setv m [3 2])
  (setv d [[1 2 4] [1 3]])
  (, N T m d))

(setv +max-d+ 10000)
(setv *e* {}) ;; 期待値テーブル
(defn get-estimate [i j]
  (global *e*)
  (safe-get *e* (, i j) 0))

(defn set-estimate [i j value]
  (global *e*)
  (assoc *e* (, i j) value))

(defn solve []
  ;; Parameters
  (setv (, N T m d) (parameter1))

  ;; Main

  ;; 各トーナメント表毎の期待値の計算
  (for [i (range T)]
    (for [j (range (get m i))]
      (setv index (, i (get d i j)))
      (set-estimate #* index (-> (get-estimate #* index) inc)))
    (for [a (range 1 (inc +max-d+))]
      (setv index1 (, i a))
      (setv index2 (, i (dec a)))
      (set-estimate #* index1 (+ (get-estimate #* index1)
                                 (get-estimate #* index2)))))

  ;; 全体の期待値の計算
  ;; K + A / Bの形でオーバーフローに注意し計算
  (setv K 0)
  (setv A 0)
  (setv B (** N 2))
  (setv a 1)
  (while (and (<= a N)
              (<= a (inc +max-d+)))
    (setv sum 0)
    (setv sum2 0)
    (for [i (range T)]
      (+= sum (get-estimate i a))
      (+= sum2 (** (get-estimate i a) 2)))
    (if (< a +max-d+)
      (do
        (+= A (+ (** sum 2) (- sum2) (* sum N)))
        (+= K (// A B))
        (%= A B))
      (do
        (setv n (+ N (- +max-d+) 1))
        (+= K (// (* sum n) N))
        (+= A (+ (* (- (** sum 2) sum2) n)
                 (% (* sum n) (** N 2))))
        (+= K (// A B))
        (%= A B)
        (when (neg? A)
          (+= A B)
          (-= K 1))))
    (+= a 1))
  (setv d (gcd A B))
  (print (.format "{0}+{1}/{2}" K (// A d) (// B d))))

(defmain
  [&rest args]
  (solve))

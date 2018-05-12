#!/usr/bin/env hy

;; ----------------------------------------
;; 星座
;; ----------------------------------------
(import sys)
(import [lib.string [substring]])
(import [lib.operations [unique]])
(import [lib.search [lower-bound]])

(setv *hash* {})
(setv *tmp* {})

(defn compute-hash [a n m P Q]
  (global *tmp*)
  (global *hash*)
  (setv B1 9973)
  (setv B2 100000007)

  (setv t1 1) ;; B1のQ乗
  (for [j (range Q)]
    (*= t1 B1))

  ;; 行方向にハッシュ値を計算
  (for [i (range n)]
    (setv e 0)
    (for [j (range Q)]
      (setv e (+ (* e B1) (ord (get a i j)))))
    (setv j 0)
    (while (<= (+ j Q) m)
      (assoc *tmp* (, i j) e)
      (when (< (+ j Q) m)
        (setv e (+ (* e B1)
                   (- (* t1 (ord (get a i j))))
                   (ord (get a i (+ j Q))))))
      (+= j 1)))

  (setv t2 1) ;; B2のP乗
  (for [i (range P)]
    (*= t2 B2))

  ;; 列方向にハッシュ値を計算
  (setv j 0)
  (while (<= (+ j Q) m)
    (setv e 0)
    (for [i (range P)]
      (setv e (+ (* e B2) (get *tmp* (, i j)))))
    (setv i 0)
    (while (<= (+ i P) n)
      (assoc *hash* (, i j) e)
      (when (< (+ i P) n)
        (setv e (+ (* e B2)
                   (- (* t2 (get *tmp* (, i j))))
                   (get *tmp* (, (+ i P) j)))))
      (+= i 1))
    (+= j 1)))

(defn parameter1 []
  ;; Answer : 1
  (setv N 3)
  (setv M 3)
  (setv P 2)
  (setv Q 2)
  (setv T 2)
  (setv field ["*00" "0**" "*00"])
  (setv patterns [["**" "*0"] ["00" "**"]])
  (, N M P Q T field patterns))

(defn solve []
  ;; Parameters
  (setv (, N M P Q T field patterns) (parameter1))

  ;; Main
  (setv unseen [])
  (for [k (range T)]
    (compute-hash (get patterns k) P Q P Q)
    (.append unseen (get *hash* (, 0 0))))

  (compute-hash field N M P Q)
  (setv i 0)
  (while (<= (+ i P) N)
    (setv j 0)
    (while (<= (+ j Q) M)
      (try
        (.remove unseen (get *hash* (, i j)))
        (except [e Exception]))
      (+= j 1))
    (+= i 1))

  (setv ans (- T (len unseen)))
  (print ans))

(defmain
  [&rest args]
  (solve))

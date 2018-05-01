#!/usr/bin/env hy

;; ----------------------------------------
;; The Windy's
;; ----------------------------------------
(import sys)
(import [lib.mincost [add-edge min-cost-flow]])

(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 2.0 (工場4で全部)
  (setv (, N M) (, 3 4))
  (setv Z (-> [[100 100 100 1]
               [99 99 99 1]
               [98 98 98 1]]))
  (, N M Z))

(defn parameter2 []
  ;; Answer : 1.0 (それぞれ1, 2, 3の工場)
  (setv (, N M) (, 3 4))
  (setv Z (-> [[1 100 100 100]
               [99 1 99 99]
               [98 98 1 98]]))
  (, N M Z))

(defn parameter3 []
  ;; Answer : 1.333333 (1, 2を1の工場、3を2の工場)
  (setv (, N M) (, 3 4))
  (setv Z (-> [[1 100 100 100]
               [1 99 99 99]
               [98 1 98 98]]))
  (, N M Z))

(defn solve []
  ;; Paramters
  (setv (, N M Z) (parameter3))

  ;; Main

  ;; 0~N-1        : おもちゃ
  ;; N~2N-1       : 0番の工場
  ;; 2N~3N-1      : 1番の工場
  ;; ...
  ;; MN~(M+1)N-1  : M-1番の工場
  (setv s (+ N (* N M)))
  (setv t (inc s))
  (setv V (inc t))
  (for [i (range N)]
    (add-edge s i 1 0))
  (for [j (range M)]
    (for [k (range N)]
      (add-edge (+ N (* j N) k) t 1 0)
      (for [i (range N)]
        (add-edge i (+ N (* j N) k) 1 (* (+ k 1) (get Z i j))))))
  (print (/ (min-cost-flow V s t N) N)))

(defmain
  [&rest args]
  (solve))


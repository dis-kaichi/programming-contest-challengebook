#!/usr/bin/env hy

;; ----------------------------------------
;; Intervals
;; ----------------------------------------
(import sys)
(import [lib.mincost [add-edge min-cost-flow]])
(import [lib.matrix [transpose]])
(import [lib.operations [unique]])
(import [lib.search [binary-search]])

(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 14(すべての区間)
  (setv (, N K) (, 3 1))
  (setv (, a b w) (-> [[1 2 2]
                       [2 3 4]
                       [3 4 8]]
                      transpose))
  (, N K a b w))

(defn parameter2 []
  ;; Answer : 12(2番と3番)
  (setv (, N K) (, 3 1))
  (setv (, a b w) (-> [[1 3 2]
                       [2 3 4]
                       [3 4 8]]
                      transpose))
  (, N K a b w))

(defn parameter3 []
  ;; Answer : 100301(1番と2番)
  (setv (, N K) (, 3 1))
  (setv (, a b w) (-> [[1 100000 100000]
                       [1 150 301]
                       [100 200 300]]
                      transpose))
  (, N K a b w))


(defn solve []
  ;; Paramters
  (setv (, N K a b w) (parameter1))

  ;; Main

  ;; 端点集合を求める
  (setv x [])
  (for [i (range N)]
    (.append x (get a i))
    (.append x (get b i)))
  (setv x (unique x)) ;; with sort

  ;; グラフを作成
  (setv m (len x))
  (setv s m)
  (setv t (inc s))
  (setv V (inc t))
  (setv res 0)
  (add-edge s 0 K 0)
  (add-edge (dec m) t K 0)
  (for [i (range (dec m))]
    (add-edge i (inc i) +inf+ 0))
  (for [i (range N)]
    (setv u (.index x (get a i)))
    (setv v (.index x (get b i)))
    ;; uからvへ容量1、コスト-w[i]の辺を張る
    (add-edge v u 1 (get w i))
    (add-edge s v 1 0)
    (add-edge u t 1 0)
    (-= res (get w i)))

  (+= res (min-cost-flow V s t (+ K N)))
  (print (- res)))

(defmain
  [&rest args]
  (solve))


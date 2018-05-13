#!/usr/bin/env hy

;; ----------------------------------------
;; Football Team
;; ----------------------------------------
(import [lib.operations [safe-get]])

(defn parameter1 []
  ;; Answer : 1(全員同じ)
  (setv N 3)
  (setv x [10 8 12])
  (setv y [10 15 7])
  (, N x y))

(defn parameter2 []
  ;; Answer : 1 (1,3,5と2,4)
  (setv N 5)
  (setv x [1 2 3 4 5])
  (setv y [1 1 1 1 1])
  (, N x y))

(defn parameter3 []
  ;; Answer : 3 (全員違う)
  (setv N 3)
  (setv x [1 2 3])
  (setv y [1 2 1])
  (, N x y))

(setv *g* {}) ;; 隣接行列
(setv *color* {}) ;; 頂点の色
(setv *used* {}) ;; 辺を既に調べたか

(defn use [v u]
  (global *used*)
  (assoc *used* (, v u) True))

(defn used? [v u]
  (safe-get *used* (, v u) False))

(defn set-color [x color]
  (global *color*)
  (assoc *color* x color))

(defn get-color [x]
  (safe-get *color* x -1))

(defn clear-color []
  (global *color*)
  (setv *color* {}))

(defn set-graph [x y value]
  (global *g*)
  (assoc *g* (, x y) value))

(defn get-graph [x y]
  (safe-get *g* (, x y) False))

;; 3彩色可能か判定する
;; 2点v,uの色が確定している時点で、v-uの辺を共有する三角形の色を再帰的に調べる
(defn rec [v u N]
  (use v u)
  (use u v)
  (setv c (- 3 (get-color v) (get-color u))) ;; 残りの色
  (for [w (range N)]
    (when (and (get-graph v w)
               (get-graph u w))
      (if (neg? (get-color w))
        (do
          (set-color w c)
          ;; 三角形の残りの2辺について再帰的に調べる
          (when (or (not (rec v w N))
                    (not (rec u w N)))
            (return False)))
        (when (!= (get-color w) c)
          ;; 同じ色で塗られている
          (return False)))))
  True)

(defn solve []
  ;; Parameters
  (setv (, N x y) (parameter3))

  ;; Main

  ;; グラフの作成
  (for [i (range N)]
    (setv v [-1 -1 -1])
    (for [j (range N)]
      (when (< (get x i) (get x j))
        (setv k (+ (get y j) (- (get y i)) 1))
        (when (and (<= 0 k)
                   (< k 3)
                   (or (neg? (get v k))
                       (< (get x j)
                          (get x (get v k)))))
          (assoc v k j))))
    (for [k (range 3)]
      (when (>= (get v k) 0)
        (set-graph i (get v k) True)
        (set-graph (get v k) i True))))

  ;; 三角形を探して彩色数を計算
  (setv res 1)

  (for [v (range N)]
    (for [u (range N)]
      (when (and (get-graph v u)
                 (not (used? v u)))
        ;; 辺が存在したら彩色数は2以上
        (setv res (max res 2))
        (for [w (range N)]
          (when (and (get-graph v w)
                     (get-graph u w))
            ;; 三角形が存在したら彩色数は3以上
            (setv res (max res 3))
            (clear-color)
            (set-color v 0)
            (set-color u 1)
            (when (not (rec v u N))
              ;; 3彩色可能でなければ彩色数は4
              (print 4)
              (return))
            (break))))))
  (print res))

(defmain
  [&rest args]
  (solve))

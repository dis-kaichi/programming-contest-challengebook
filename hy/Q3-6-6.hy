#!/usr/bin/env hy

;; ----------------------------------------
;; Intersection of Two Prisms
;; ----------------------------------------
(import sys)
(import [lib.matrix [transpose]])
(import [lib.sequences [min-element max-element]])

(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 4.7083333333
  (setv (, M N) (, 4 3))
  (setv (, X1 Y1) (-> [[7 2]
                       [3 3]
                       [0 2]
                       [3 1]]
                      transpose))
  (setv (, X2 Z2) (-> [[4 2]
                       [0 1]
                       [8 1]]
                      transpose))
  (, M N X1 Y1 X2 Z2))

;; 多角形をxの値でスライスした時の幅を求める
(defn width [X Y n x]
  (setv (, lb ub) (, +inf+ (- +inf+)))
  (for [i (range n)]
    (setv x1 (get X i))
    (setv y1 (get Y i))
    (setv x2 (get X (% (+ i 1) n)))
    (setv y2 (get Y (% (+ i 1) n)))
    ;; i番目の辺と交点を持つかどうか調べる
    (when (and (<= (* (- x1 x) (- x2 x)) 0)
               (!= x1 x2))
      ;; 交点の座標を計算
      (setv y (+ y1 (/ (* (- y2 y1) (- x x1)) (- x2 x1))))
      (setv lb (min lb y))
      (setv ub (max ub y))))
  (max 0.0 (- ub lb)))

(defn solve []
  ;; Parameters
  (setv (, M N X1 Y1 X2 Z2) (parameter1))

  ;; Main

  ;; 区間の端点を列挙
  (setv (, min1 max1) (, (min-element X1) (max-element X1)))
  (setv (, min2 max2) (, (min-element X2) (max-element X2)))

  (setv xs [])
  (for [i (range M)]
    (.append xs (get X1 i)))
  (for [i (range N)]
    (.append xs (get X2 i)))
  (.sort xs)

  (setv res 0)
  (for [i (range (dec (len xs)))]
    (setv a (get xs i))
    (setv b (get xs (inc i)))
    (setv c (/ (+ a b) 2))
    (when (and (<= min1 c)
               (<= c max1)
               (<= min2 c)
               (<= c max2))
      ;; シンプソンの公式で積分
      (setv fa (* (width X1 Y1 M a) (width X2 Z2 N a)))
      (setv fb (* (width X1 Y1 M b) (width X2 Z2 N b)))
      (setv fc (* (width X1 Y1 M c) (width X2 Z2 N c)))
      (+= res (* (/ (- b a) 6) (+ fa (* 4 fc) fb)))))
  (print (.format "{0:.10f}" res)))

(defmain
  [&rest args]
  (solve))


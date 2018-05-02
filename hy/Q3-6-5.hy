#!/usr/bin/env hy

;; ----------------------------------------
;; Beauty Contest (キャリパー法)
;; ----------------------------------------

(import [lib.point [Point]])
(import [lib.convex [convex-hull]])

(defn list-to-point [xs]
  (Point #* xs))

(defn lists-to-points [xs]
  (list (map list-to-point xs)))

(defn parameter1 []
  ;; Answer : 80 ((1,8)と(5,0))
  (setv N 8)
  (setv ps (-> [[0 5]
                [1 8]
                [3 4]
                [5 0]
                [6 2]
                [6 6]
                [8 3]
                [8 7]]
               lists-to-points))
  (, N ps))

;; 距離の2乗
(defn dist [p q]
  (.dot (- p q)
        (- p q)))

(defn solve []
  ;; Parameters
  (setv (, N ps) (parameter1))

  ;; Main
  (setv qs (convex-hull ps N))
  (setv n (len qs))
  (if (= n 2)
    ;; 凸包が潰れている場合は特別処理
    (print (.format "{0:.0f}" (dist (get qs 0) (get qs 1))))
    (do
      (setv (, i j) (, 0 0)) ;; ある方向に最も遠い点
      ;; X軸方向に最も遠い点対を求める
      (for [k (range n)]
        (when (not (< (get qs i) (get qs k)))
          (setv i k))
        (when (< (get qs j) (get qs k))
          (setv j k)))
      (setv res 0)
      (setv (, si sj) (, i j))
      (while (or (!= i sj)
                 (!= j si)) ;; 方向を180度変化させる
        (setv res (max res (dist (get qs i) (get qs j))))
        ;; 辺i-(i+1)の法線方向と辺j-(j+1)の法線方向のどちらを先に向くか判定
        (if (neg? (.det (- (get qs (% (+ i 1) n)) (get qs i))
                        (- (get qs (% (+ j 1) n)) (get qs j))))
          (setv i (% (+ i 1) n)) ;; 辺i-(i+1)の法線方向を先に向く
          (setv j (% (+ j 1) n)) ;; 辺j-(j+1)の法線方向を先に向く
          ))
      (print (.format "{0:.0f}" res)))))


(defmain
  [&rest args]
  (solve))


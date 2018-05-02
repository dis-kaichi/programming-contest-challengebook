#!/usr/bin/env hy

;; ----------------------------------------
;; 凸包関連
;; ----------------------------------------

;; Functions

;; 凸包を求める (use point.hy)
(defn convex-hull [ps n]
  (.sort ps)
  (setv default-value 0)
  (setv k 0)                ;; 凸包の頂点数
  (setv qs (* [default-value] (* n 2))) ;; 構築中の凸包
  ;; 下側凸包の作成
  (for [i (range n)]
    (while (and (> k 1)
                (<= (.det (- (get qs (- k 1))
                             (get qs (- k 2)))
                          (- (get ps i)
                             (get qs (- k 1))))
                    0))
      (-= k 1))
    (assoc qs k (get ps i))
    (+= k 1))
  ;; 上側凸包の作成
  (setv t k)
  (for [i (range (- n 2) -1 -1)]
    (while (and (> k t)
                (<= (.det (- (get qs (- k 1))
                             (get qs (- k 2)))
                          (- (get ps i)
                             (get qs (- k 1))))
                    0))
      (-= k 1))
    (assoc qs k (get ps i))
    (+= k 1))
  (setv no-data-index (.index qs default-value))
  (list (take (dec no-data-index) qs)))


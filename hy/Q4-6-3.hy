#!/usr/bin/env hy

;; ----------------------------------------
;; 最近点対問題
;; ----------------------------------------
(import sys)
(import [math [sqrt]])
(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 36.2215
  (setv n 5)
  (setv x [0 6 43 39 189])
  (setv y [2 67 71 107 140])
  (, n x y))

(defn closest-pair [a n]
  (if (<= n 1)
    +inf+
    (do
      (setv m (// n 2))
      (setv x (get a m 0))
      (setv d (min (closest-pair a m)
                   (closest-pair (cut a m) (- n m)))) ;; (1)
      (.sort a #** {"key" second})
      ;; この時点でaはy座標の昇順になっている

      ;; (2')
      (setv b []) ;; 直線から距離d未満の頂点を入れていく
      (for [i (range n)]
        (when (>= (abs (- (get a i 0) x)) d)
          (continue))
        ;; bに入っている頂点を、末尾から、y座標の差がd以上になるまで見ていく
        (for [j (range (len b))]
          (setv dx (- (get a i 0) (get b (- (len b) j 1) 0)))
          (setv dy (- (get a i 1) (get b (- (len b) j 1) 1)))
          (when (>= dy d)
            (break))
          (setv d (min d (sqrt (+ (** dx 2) (** dy 2))))))
        (.append b (get a i)))
      d)))

(defn solve []
  ;; Parameters
  (setv (, N x y) (parameter1))

  ;; Main
  (setv a (list (zip x y)))
  (.sort a) ;; x座標でソート
  (print (.format "{0:.4f}" (closest-pair a N))))

(defmain
  [&rest args]
  (solve))


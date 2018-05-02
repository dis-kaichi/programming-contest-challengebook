#!/usr/bin/env hy

;; ----------------------------------------
;; Watering Plants
;; ----------------------------------------

(import [math [sqrt]])
(import [lib.matrix [transpose]])
(import [lib.operations [LoopEnd]])

(defn seats-to-values [seats]
  (list (map list seats)))

(defn parameter1 []
  ;; Answer : 7.0
  (setv N 3)
  (setv (, X Y R) (-> [[20 10 2]
                       [20 20 2]
                       [40 10 3]]
                      transpose))
  (, N X Y R))

(defn parameter2 []
  ;; Answer : 8.0
  (setv N 3)
  (setv (, X Y R) (-> [[20 10 3]
                       [30 10 3]
                       [40 10 3]]
                      transpose))
  (, N X Y R))

;; 中心(x,y)半径rの円が囲う集合を求める
(defn cover [x y r N X Y R]
  (setv S 0)
  (for [i (range N)]
    (setv dx (- x (get X i)))
    (setv dy (- y (get Y i)))
    (setv dr (- r (get R i)))
    (when (<= (+ (* dx dx) (* dy dy))
              (* dr dr))
      (|= S (<< 1 i))))
  S)

;; 半径rの円2つですべてを囲うことが可能か判定
(defn C? [r N X Y R]
  (setv cand []) ;; 1つの円で囲える集合のリスト
  (.append cand 0)

  ;; パターンa
  (for [i (range N)]
    (for [j (range i)]
      (when (and (< (get R i) r) (< (get R j) r))
        ;; 二円の交点を計算
        (setv (, x1 y1 r1) (, (get X i) (get Y i) (- r (get R i))))
        (setv (, x2 y2 r2) (, (get X j) (get Y j) (- r (get R j))))
        (setv (, dx dy) (, (- x2 x1) (- y2 y1)))
        (setv a (+ (* dx dx) (* dy dy)))
        (setv b (/ (+ (/ (- (* r1 r1) (* r2 r2)) a) 1) 2))
        (setv d (- (/ (* r1 r1) a) (* b b)))
        (when (>= d 0)
          (setv d (sqrt d))
          (setv x3 (+ x1 (* dx b)))
          (setv y3 (+ y1 (* dy b)))
          (setv x4 (* (- dy) d))
          (setv y4 (* dx d))
          ;; 誤差を考慮し、iとjは特別扱いする
          (setv ij (| (<< 1 i) (<< 1 j)))
          (.append cand (| (cover (- x3 x4) (- y3 y4) r N X Y R) ij))
          (.append cand (| (cover (+ x3 x4) (+ y3 y4) r N X Y R) ij))))))

  ;; パターンb
  (for [i (range N)]
    (when (<= (get R i) r)
      (.append cand (| (cover (get X i) (get Y i) r N X Y R) (<< 1 i)))))


  ;; 円の候補から2つ取り出してすべてを囲えているか調べる
  (try
    (for [i (range (len cand))]
      (for [j (range i)]
        (when (= (| (get cand i) (get cand j))
                 (- (<< 1 N) 1))
          (raise LoopEnd))))
    False
    (except [e LoopEnd]
            True)))

(defn solve []
  ;; Parameters
  (setv (, N X Y R) (parameter1))

  ;; Main

  ;; 半径rを二分探索
  (setv (, lb ub) (, 0 10000))
  (for [i (range 100)]
    (setv mid (/ (+ lb ub) 2))
    (if (C? mid N X Y R)
      (setv ub mid)
      (setv lb mid)))
  (print (.format "{0:.6}" ub)))

(defmain
  [&rest args]
  (solve))


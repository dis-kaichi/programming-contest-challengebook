#!/usr/bin/env hy

;; ----------------------------------------
;; White Bird
;; ----------------------------------------

(import [math [sqrt]])
(import [lib.operations [LoopEnd]])
(import [lib.matrix [transpose create-matrix]])
(import [lib.point [Point on-segment? intersection]])

(setv +g+ 9.8) ;; 重力加速度
(setv +eps+ (** 10 -10))

(defn parameter1 []
  ;; Answer : Yes
  (setv (, N V) (, 0 7))
  (setv (, X Y) (, 3 1))
  (setv (, L B R T) (-> [[] [] [] []]))
  (, N V X Y L B R T))

(defn parameter2 []
  ;; Answer : Yes
  (setv (, N V) (, 1 7))
  (setv (, X Y) (, 3 1))
  (setv (, L B R T) (-> [[1 1 2 2]]
                        transpose))
  (, N V X Y L B R T))

;; 速度vyで上に打ち出した時のt秒後の位置を計算する
(defn calc [vy t]
  (- (* vy t)
     (/ (* +g+ t t) 2)))

;; aのlbとubに対する相対的な位置
(defn cmp [lb ub a]
  (if (< a (+ lb +eps+))
    -1
    (if (> a (- ub +eps+))
      1
      0)))

;; 点(qx, qy)を通るように打ち出した時に豚に卵をぶつけられるか判定
(defn check [qx qy N V X Y L B R T]
  ;; 初速のx方向成分をvx、y方向をvyとし、(qx, qy)を通る時刻をtとした時の連立方程式
  ;; vx^2 + vy^2 = V^2
  ;; vx * t = qx
  ;; vy * t - g*t^2/2 = qy
  ;; を解く
  (setv a (/ (* +g+ +g+) 4))
  (setv b (- (* +g+ qy) (* V V)))
  (setv c (+ (* qx qx) (* qy qy)))
  (setv D (- (* b b) (* 4 a c)))
  (when (and (neg? D)
             (> D +eps+))
    (setv D 0))
  (if (neg? D)
    False
    (do
      ;; 連立方程式の2つの解を試すループ
      (setv result False)
      (try
        (for [d (range -1 2 2)]
          (setv t2 (/ (+ (- b) (* d (sqrt D))) (* 2 a)))
          (when (<= t2 0)
            (continue))
          (setv t (sqrt t2))
          (setv vx (/ qx t))
          (setv vy (/ (+ qy (/ (* +g+ t t) 2)) t))

          ;; 豚より上を通過できるか判定
          (setv yt (calc vy (/ X vx)))
          (when (< yt (- Y +eps+))
            (continue))

          (setv ok True)
          (for [i (range N)]
            (when (>= (get L i) X)
              (continue))
            ;; 豚の真上まで来た時に、間に障害物がないか判定
            (when (and (= (get R i) X)
                       (<= Y (get T i))
                       (<= (get B i) yt))
              (setv ok False))
            ;; 途中で障害物にぶつからないか判定
            (setv yL (cmp (get B i) (get T i) (calc vy (/ (get L i) vx)))) ;; 左端での相対位置
            (setv yR (cmp (get B i) (get T i) (calc vy (/ (get R i) vx)))) ;; 右端での相対位置
            (setv xH (cmp (get L i) (get R i) (* vx (/ vy +g+)))) ;; 最も高くなる地点の相対位置
            (setv yH (cmp (get B i) (get T i) (calc vy (/ vy +g+))))
            (when (and (zero? xH)
                       (>= yH 0)
                       (< yL 0))
              (setv ok False))
            (when (<= (* yL yR) 0)
              (setv ok False)))
          (when ok
            (setv result True)
            (raise LoopEnd)))
        (setv result False)
        (except [LoopEnd]))
      result)))

(defn solve []
  ;; Parameters
  (setv (, N V X Y L B R T) (parameter1))

  ;; Main

  ;; 豚より右にある障害物をまとめておく
  (for [i (range N)]
    (assoc R i (min (get R i) X)))
  (setv ok (check X Y N V X Y L B R T)) ;; 直接ぶつける場合
  (for [i (range N)]
    (|= ok (check (get L i) (get T i) N V X Y L B R T)) ;; 左上の角を通る場合
    (|= ok (check (get R i) (get T i) N V X Y L B R T)) ;; 右上の角を通る場合
    )
  (print (if ok
           "Yes"
           "No")))

(defmain
  [&rest args]
  (solve))


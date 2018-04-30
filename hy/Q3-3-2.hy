#!/usr/bin/env hy

;; ----------------------------------------
;; Crane
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(import [sys])
(import [math [floor cos sin pi]])

(setv data
  ["3 2"      ;; -10.00 5.00
   "5 5 5"    ;; -5.00 10.00
   "1 2"
   "270 90"])

(setv +st-size+ (dec (<< 1 15)))
(setv +max-n+ (<< 1 17))

(defn double [x] (* x 2))
(defn floor-half [x] (floor (/ x 2)))

;; セグメント木を初期化する
;;  k   : 節点の番号
;;  l,r : その節点が[l, r)に対応づいていることを表す
(defn init [vx vy ang L k l r]
  (assoc ang k 0.0)
  (assoc vx k 0.0)

  (if (= (dec r) l)
    ;; 葉
    (assoc vy k (nth L l))
    ;; 葉でない節点
    (do
      (setv chl (+ (double k) 1))
      (setv chr (+ (double k) 2))
      (init vx vy ang L chl l (floor-half (+ l r)))
      (init vx vy ang L chr (floor-half (+ l r)) r)
      (assoc vy k (+ (nth vy chl) (nth vy chr))))))

(defmacro +=! [array index value]
  `(assoc ~array ~index (+ (nth ~array ~index) ~value)))

;; 場所sの角度がaだけ変更になった
;;  v    : 節点の番号
;;  l, r : その節点が[l, r)に対応づいていることを表す
(defn change [vx vy ang s a v l r]
  (when (and (not (<= s l))
             (< s r))
    (setv chl (+ (double v) 1))
    (setv chr (+ (double v) 2))
    (setv m (floor-half (+ l r)))
    (change vx vy ang s a chl l m)
    (change vx vy ang s a chr m r)
    (when (<= s m)
      (+=! ang v a))
    (setv s (sin (nth ang v)))
    (setv c (cos (nth ang v)))
    (assoc vx v (+ (nth vx chl)
                   (- (* c (nth vx chr))
                      (* s (nth vy chr)))))
    (assoc vy v (+ (nth vy chl)
                   (+ (* s (nth vx chr))
                      (* c (nth vy chr)))))))

(defn map-int [x] (list (map int x)))
(defn solve []
  ;; Parameters
  (setv (, N C) (-> data (nth 0) (.split " ") map-int))
  (setv L (-> data (nth 1) (.split " ") map-int))
  (setv S (-> data (nth 2) (.split " ") map-int))
  (setv A (-> data (nth 3) (.split " ") map-int))
  ;; Main
  (setv vx (* [0.0] +st-size+))   ;; 各節点のベクトル
  (setv vy (* [0.0] +st-size+))   ;; 各節点のベクトル
  (setv ang (* [0.0] +st-size+))  ;; 各節点の角度

  ;; 角度の変化を調べるため、現在の角度を保存しておく
  (setv prv (* [0.0] +max-n+))

  ;; 初期化
  (init vx vy ang L 0 0 N)
  (for [i (range 1 N)] (assoc prv i pi))

  ;; 各クエリを処理
  (for [i (range C)]
    (setv s (nth S i))
    (setv a (* (/ (nth A i) 360.0) 2 pi)) ;; ラジアンに戻す

    (change vx vy ang s (- a (nth prv s)) 0 0 N)
    (assoc prv s a)
    (print (.format "{0:.2f} {1:.2f}" (nth vx 0) (nth vy 0)))))

(defmain
  [&rest args]
  (solve))

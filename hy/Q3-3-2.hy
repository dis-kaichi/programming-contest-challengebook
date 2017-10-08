#!/usr/bin/env hy

;; ----------------------------------------
;; Crane
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(import [sys])
(import [math [floor cos sin pi]])

(def data
  ["3 2"      ;; -10.00 5.00
   "5 5 5"    ;; -5.00 10.00
   "1 2"
   "270 90"])

; ----------------------------------------
; Start セグメント木
; ----------------------------------------
;(def +max-n+ (<< 1 17))
;
;;; セグメント木を持つグローバル配列
;(def *n* 0)
;(def *dat* (* [0] (* 2 (dec +max-n+))))
;
;(defmacro *= [x value] `(setv ~x (* ~x ~value)))
;(defmacro += [x value] `(setv ~x (+ ~x ~value)))
;
;;; 初期化
;(defn init [_n]
;  ;; 簡単のため、要素数を２の冪乗に
;  (global *n*)
;  (setv *n* 1)
;  (while (< *n* _n)
;    (*= *n* 2))
;  ;; すべての値をintの最大値に
;  (for [i (range (* 2 (dec *n*)))]
;    (assoc *dat* i (. sys maxsize))))
;
;;; k番目の値(0-indexed)をaに変更
;(defn update [k a]
;  ;; 葉の節点
;  (+= k (dec *n*))
;  (assoc *dat* k a)
;  ;; 登りながら更新
;  (while (> k 0)
;    (setv k (floor (/ (dec k) 2)))
;    (assoc *dat* k (min (nth *dat* (+ (* k 2) 1))
;                        (nth *dat* (+ (* k 2) 2))))))
;
;;; [a, b)の最小値を求める
;;; 後ろの方の引数は、計算の簡単のための引数
;;; kは節点の番号、l, rはその節点が[l, r)に対応していることを表す。
;;; したがって外からはquery(a, b, 0, 0, n)として呼ぶ
;(defn query [a b k l r]
;  ;; [a, b)と[l, r)が交差しなければ、int max
;  (if (or (<= r a) (<= b l))
;    (. sys maxsize)
;    (do
;      ;; [a, b)が[l, r)を完全に含んでいれば、この節点の値
;      (if (and (<= a l) (<= r b))
;        (nth *dat* k)
;        (do
;          ;; そうでなければ、２つの子の最小値
;          (setv vl (query a b (+ (* k 2) 1) l (floor (/ (+ l r) 2))))
;          (setv vr (query a b (+ (* k 2) 2) (floor (/ (+ l r) 2)) r))
;          (min vl vr))))))
; ----------------------------------------
; END セグメント木
; ----------------------------------------

(def +st-size+ (dec (<< 1 15)))
(def +max-n+ (<< 1 17))

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

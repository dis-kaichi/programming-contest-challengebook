#!/usr/bin/env hy

;; ----------------------------------------
;; セグメント木
;; ----------------------------------------
(import [sys])
(import [math [floor]])

(def +max-n+ (<< 1 17))

;; セグメント木を持つグローバル配列
(def *n* 0)
(def *dat* (* [0] (* 2 (dec +max-n+))))

(defmacro *= [x value] `(setv ~x (* ~x ~value)))
(defmacro += [x value] `(setv ~x (+ ~x ~value)))

;; 初期化
(defn init [_n]
  ;; 簡単のため、要素数を２の冪乗に
  (global *n*)
  (setv *n* 1)
  (while (< *n* _n)
    (*= *n* 2))
  ;; すべての値をintの最大値に
  (for [i (range (* 2 (dec *n*)))]
    (assoc *dat* i (. sys maxsize))))

;; k番目の値(0-indexed)をaに変更
(defn update [k a]
  ;; 葉の節点
  (+= k (dec *n*))
  (assoc *dat* k a)
  ;; 登りながら更新
  (while (> k 0)
    (setv k (floor (/ (dec k) 2)))
    (assoc *dat* k (min (nth *dat* (+ (* k 2) 1))
                        (nth *dat* (+ (* k 2) 2))))))

;; [a, b)の最小値を求める
;; 後ろの方の引数は、計算の簡単のための引数
;; kは節点の番号、l, rはその節点が[l, r)に対応していることを表す。
;; したがって外からはquery(a, b, 0, 0, n)として呼ぶ
(defn query [a b k l r]
  ;; [a, b)と[l, r)が交差しなければ、int max
  (if (or (<= r a) (<= b l))
    (. sys maxsize)
    (do
      ;; [a, b)が[l, r)を完全に含んでいれば、この節点の値
      (if (and (<= a l) (<= r b))
        (nth *dat* k)
        (do
          ;; そうでなければ、２つの子の最小値
          (setv vl (query a b (+ (* k 2) 1) l (floor (/ (+ l r) 2))))
          (setv vr (query a b (+ (* k 2) 2) (floor (/ (+ l r) 2)) r))
          (min vl vr))))))

(defn solve []
  (init 5)
  ;; p153の状態
  (update 0 5)
  (update 1 3)
  (update 2 7)
  (update 3 9)
  (update 4 6)
  (update 5 4)
  (update 6 1)
  (update 7 2)
  ;; a0...a6の最小値
  (print (query 0 7 0 0 *n*))
  (-> *dat*
      (->> (take 15))
      list
      print)
  )

(defmain
  [&rest args]
  (solve))


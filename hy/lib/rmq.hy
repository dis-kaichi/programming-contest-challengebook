#!/usr/bin/env hy

(import sys)

;; セグメント木を持つグローバル配列
(setv *n* 0)
(setv *dat* {})

;; 初期化
(defn init [nn]
  ;; 簡単のため、要素数を２の冪乗に
  (global *n*)
  (setv *n* 1)
  (while (< *n* nn)
    (*= *n* 2))
  ;; すべての値をintの最大値に
  (for [i (range (dec (* 2 *n*)))]
    (assoc *dat* i (. sys maxsize))))

;; k番目の値(0-indexed)をaに変更
(defn update [k a]
  ;; 葉の節点
  (+= k (dec *n*))
  (assoc *dat* k a)
  ;; 登りながら更新
  (while (> k 0)
    (setv k (// (dec k) 2))
    (assoc *dat* k (min (get *dat* (+ (* k 2) 1))
                        (get *dat* (+ (* k 2) 2))))))

;; [a, b)の最小値を求める
;; 後ろの方の引数は、計算の簡単のための引数
;; kは節点の番号、l, rはその節点が[l, r)に対応していることを表す。
;; したがって外からはquery(a, b, 0, 0, n)として呼ぶ
;; => Optional化したので、query(a, b)で良い
(defn query [a b &optional [k 0] [l 0] [r None]]
  (when (none? r)
    (setv r *n*))
  ;; [a, b)と[l, r)が交差しなければ、int max
  (if (or (<= r a) (<= b l))
    (. sys maxsize)
    (do
      ;; [a, b)が[l, r)を完全に含んでいれば、この節点の値
      (if (and (<= a l) (<= r b))
        (get *dat* k)
        (do
          ;; そうでなければ、２つの子の最小値
          (setv vl (query a b (+ (* k 2) 1) l (// (+ l r) 2)))
          (setv vr (query a b (+ (* k 2) 2) (// (+ l r) 2) r))
          (min vl vr))))))

(defn dump-dat []
  (print *dat*))

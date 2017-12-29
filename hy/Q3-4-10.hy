#!/usr/bin/env hy

;; ----------------------------------------
;; Minimizing maximizer
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-pipe]])

(def data
  ["40 6"
   "20 30"
   "1 10"
   "10 20"
   "20 30"
   "15 25"
   "30 40"
   ])

(def +m+ 10007)

(import [sys])
(import [math [floor]])

(def +inf+ (. sys maxsize))

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
    (assoc *dat* i +inf+)))

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

(defn convert-2-lists [lines]
  (setv list1 [])
  (setv list2 [])
  (for [line lines]
    (setv (, s t) (-> line (.split " ") ((fn [x] (map int x))) list))
    (.append list1 s)
    (.append list2 t))
  (, list1 list2))

(def *dp* {}) ;; DPテーブル

(defn safe-get [-dict -key &optional [default -1]]
  (try
    (get -dict -key)
    (except [e KeyError]
            default)))

(defn solve []
  ;; Parameters
  (setv (, n m) (-> data first (.split " ") ((fn [x] (map int x)))))
  (setv (, s t) (-> data rest convert-2-lists))
  ;; Main
  (init n) ;; セグメント木を初期化
  (assoc *dp* 1 0)
  (update 1 0)
  (for [i (range m)]
    (setv v (min (safe-get *dp* (nth t i) +inf+)
                 ;; 1-indexedなので起点を1とする
                 (inc (query (nth s i) (inc (nth t i)) 1 0 n))))
    (assoc *dp* (nth t i) v)
    (update (nth t i) v))
  (print (safe-get *dp* n +inf+)))

(defmain
  [&rest args]
  (solve))


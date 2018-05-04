#!/usr/bin/env hy

;; ----------------------------------------
;; 代数関連
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [lib.operations [LoopEnd safe-get]])

;; 最大公約数
(defn gcd [x y]
  (loop [[a x]
         [b y]]
    (if (= b 0)
      a
      (recur b (% a b)))))

;; 最大公約数(拡張)
(defn extgcd [a b]
  ;; ax + by = d となる [x y d] を返す
  (if (zero? b)
    [1 0 a]
    (do
      (setv prev (extgcd b (% a b)))
      [(second prev)
       (- (first prev) (* (second prev) (// a b)))
       a])))

;; 逆元
(defn mod-inverse [a m]
  (setv (, x y d) (extgcd a m))
    (% (+ m (% x m)) m))

;; オイラー関数の値を求める(O(sqrt(n)))
(defn euler-phi [n]
  (setv (, res n)
        (loop [[i 2]
               [res n]
               [nn n]]
          (if (not (<= (** i 2) nn))
            (, res nn)
            (do
              (when (zero? (% nn i))
                (setv res (* (// res i) (dec i)))
                (while (zero? (% nn i))
                  (//= nn i)))
              (recur (inc i) res nn)))))
  (when (!= n 1)
    (setv res (* (// res n) (dec n))))
  res)

;; オイラー関数値テーブルを作成(O(MAX_N))
(setv *euler* [])
(defn euler-phi2 [max-n]
  (global *euler*)
  (setv *euler* (list (range max-n)))
  (for [i (range 2 max-n)]
    (when (= (get *euler* i) i)
      (setv j i)
      (while (< j max-n)
        (assoc *euler* j (* (// (get *euler* j) i) (dec i)))
        (+= j i)))))

;; オイラー関数値テーブル取得
(defn get-eulers []
  *euler*)

;; 連立線形合同式
;;    (b, m)のペアを返す
(defn linear-congruence [A B M]
  ;; 最初は条件が無いので、すべての整数を意味するx≡0(mod1)を解としておく
  (setv (, x m) (, 0 1))
  (try
    (for [i (range (len A))]
      (setv a (* (get A i) m))
      (setv b (- (get B i) (* (get A i) x)))
      (setv d (gcd (get M i) a))
      (when (not (zero? (% b d)))
        (raise LoopEnd))
      (setv t (% (* (// b d)
                    (mod-inverse (// a d) (// (get M i) d)))
                 (// (get M i) d)))
      (setv x (+ x (* m t)))
      (*= m (// (get M i) d)))
    (, (% x m) m)
    (except [e LoopEnd]
            (, 0 -1) ;; 解が無い
            )))

;;; nの階乗
;(setv *fact* {})
;(defn init-mod-fact [n]
;  ;; modの階乗を計算する必要があるので以下ではダメ
;  (if (<= n 0)
;    (do
;      (assoc *fact* n 1)
;      1)
;    (do
;      (if (in n *fact*)
;        (get *fact* n)
;        (do
;          (setv res (* n (init-mod-fact (dec n))))
;          (assoc *fact* n res)
;          res)))))
;;;  n != p^eとした時のa mod pを求める
;(defn mod-fact [n p]
;  (global *fact*)
;  (setv e 0)
;  (if (zero? n)
;    (, 1 e)
;    (do
;      ;; pの倍数の部分を計算
;      (setv (, res e) (mod-fact (// n p) p))
;      (+= e (// n p))
;
;      ;; (p-1)!≡-1なので(p-1)!^(n/p)はn/pの偶奇だけで計算できる
;      (if (not (zero? (% (// n p) 2)))
;        (, (% (* res (- p (get *fact* (% n p)))) p) e)
;        (, (% (* res (get *fact* (% n p))) p) e)))))


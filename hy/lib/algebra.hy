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

;; 冪乗計算
;(defn mod-pow [x n md]
;  (loop [[cn n]
;         [cx x]
;         [res 1]]
;    (if (<= cn 0)
;      res
;      (do
;        (when (= (& cn 1) 1)
;          (setv res (% (* res cx) md)))
;        (recur (>> cn 1) (% (pow cx 2) md) res)))))
(defn mod-pow [x n md]
  (setv res 1)
  (while (pos? n)
    (when (& n 1)
      (setv res (% (* res x) md))) ;; 最下位bitが立っている時にx^(2^i)を掛ける
    (setv x (% (** x 2) md)) ;; xを順次二乗していく
    (>>= n 1))
  res)

;; 冪乗計算(Ver2)
(defn mod-pow-v2 [x n md]
  (if (zero? n)
    1
    (do
      (setv res (mod-pow-v2 (% (pow x 2) md) (// n 2) md))
      (when (= (& n 1) 1)
        (setv res (% (* res x) md)))
      res)))

(defn prime-factor [n]
  (setv res {})
  (setv i 2)
  (while (<= (** i 2) n)
    (while (zero? (% n i))
      (assoc res i (inc (safe-get res i 0)))
      (//= n i))
    (+= i 1))
  (when (!= n 1)
    (assoc res n 1))
  res)

(defn prime? [n]
  (loop [[i 2]]
    (if (> (** i 2) n)
      (!= (% n i) 1)
      (if (zero? (% n i))
        False
        (recur (inc i))))))

(defn divisor [n]
  (loop [[i 1]
         [res []]]
    (if (> (pow i 2) n)
      res
      (if (zero? (% n i))
        (if (!= i (// n i))
          (recur (inc i) (+ res [i (// n i)]))
          (recur (inc i) (+ res [i])))
        (recur (inc i) res)))))


;;; nの階乗
(setv *fact* {})
(defn init-fact [n p]
  (global *fact*)
  (assoc *fact* 0 1)
  (assoc *fact* 1 1)
  (loop [[i 2]
         [res 1]]
    (when (<= i n)
      (setv ff (* i res))
      (assoc *fact* i ff)
      (recur (inc i) ff))))

;;  n != p^eとした時のa mod pを求める
(defn mod-fact [n p]
  (global *fact*)
  (setv e 0)
  (if (zero? n)
    (, 1 e)
    (do
      ;; pの倍数の部分を計算
      (setv (, res e) (mod-fact (// n p) p))
      (+= e (// n p))

      ;; (p-1)!≡-1なので(p-1)!^(n/p)はn/pの偶奇だけで計算できる
      (if (not (zero? (% (// n p) 2)))
        (, (% (* res (- p (get *fact* (% n p)))) p) e)
        (, (% (* res (get *fact* (% n p))) p) e)))))

;; nCk mod pを求める
(defn mod-comb [n k p]
  (when (or (neg? n)
            (neg? k)
            (< n k))
    (return 0))
  (setv (, a1 e1) (mod-fact n p))
  (setv (, a2 e2) (mod-fact k p))
  (setv (, a3 e3) (mod-fact (- n k) p))
  (if (> e1 (+ e2 e3))
    0
    (% (* a1 (mod-inverse (% (* a2 a3) p) p)) p)))


;(init-fact 10 100)
;;(print *fact*)
;(print (mod-fact 4 100007))
;(print (mod-comb 4 2 100007))

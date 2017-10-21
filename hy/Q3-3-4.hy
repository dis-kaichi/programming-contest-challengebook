#!/usr/bin/env hy

;; ----------------------------------------
;; A Simple Problem with Integers
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [math [floor]])

(def +dat-size+ (dec (<< 1 18)))

(def data
  ["8 2"
   "5 3 7 9 6 4 1 2"
   "C 0 4 1"
   "Q 0 4 0"
   ])

(defn map-int [xs] (list (map int xs)))
(defn conj [coll x]
  (+ coll [x]))

(defmacro += [xs i value] `(assoc ~xs ~i (+ (nth ~xs ~i) ~value)))

(defn convert-queries [xs]
  (loop [[queries xs]
         [T []]
         [L []]
         [R []]
         [X []]]
    (if (empty? queries)
      [T L R X]
      (do
        (setv (, t l r x) (.split (first queries) " "))
        (recur (list (rest queries))
               (conj T t)
               (conj L (int l))
               (conj R (int r))
               (conj X (int x)))))))

(defn double [x] (* x 2))
(defn floor-half-int [x] (int (floor (/ x 2))))

;; [a, b)にxを加算する
;; kは節点の番号で、区間[l, r)に対応する
(defn add [dat-a dat-b a b x k l r]
  (if (and (<= a l) (<= r b))
    (+= dat-a k x)
    (when (and (< l b) (< a r))
      (+= dat-b k (* x (- (min b r) (max a l))))
      (add dat-a dat-b a b x (+ (double k) 1) l (floor-half-int (+ l r)))
      (add dat-a dat-b a b x (+ (double k) 2) (floor-half-int (+ l r)) r))))

;; [a, b)の和を計算する
;; kは節点の番号で、区間[l, r)に対応する
(defn sum [dat-a dat-b a b k l r]
  (if (or (<= b l) (<= r a))
    0
    (if (and (<= a l) (<= r b))
      (+ (* (nth dat-a k) (- r l)) (nth dat-b k))
      (do
        (setv res (* (- (min b r) (max a l)) (nth dat-a k)))
        (setv res (+ res (sum dat-a dat-b a b (+ (double k) 1) l (floor-half-int (+ l r)))))
        (setv res (+ res (sum dat-a dat-b a b (+ (double k) 2) (floor-half-int (+ l r)) r)))
        res))))

(defn solve []
  ;; Parameters
  (setv (, N Q) (-> data first (.split " ") map-int))
  (setv A (-> data second (.split " ") map-int))
  (setv (, T L R X) (-> data (cut 2) list convert-queries))
  ;; Main

  ;; セグメント木
  (setv dat-a (* [0] +dat-size+))
  (setv dat-b (* [0] +dat-size+))

  (for [i (range N)]
    (add dat-a dat-b i (inc i) (nth A i) 0 0 N))
  (for [i (range Q)]
    (if (= (nth T i) "C")
      (add dat-a dat-b (nth L i) (inc (nth R i)) (nth X i) 0 0 N)
      (print (sum dat-a dat-b (nth L i) (inc (nth R i)) 0 0 N)))))

(defmain
  [&rest args]
  (solve))


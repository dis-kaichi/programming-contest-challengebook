#!/usr/bin/env hy

;; ----------------------------------------
;; K-th Number
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [lib.search [upper-bound]])

(setv data
  ["7 3"
   "1 5 2 6 3 7 4"
   "2 5 3"
   "4 4 1"
   "1 7 3"]) ;; 5 6 3

(setv +B+ 1000)   ;; バケットのサイズ
(setv +max-n+ 10000) ;;

(defn map-int [xs] (list (map int xs)))

(defn conj [coll x]
  (+ coll [x]))

(defn convert-queries [queries]
  (loop [[query queries]
         [I []]
         [JJ []]
         [K []]]
    (setv current (first query))
    (if (none? current)
      [I JJ K]
      (do
        (setv (, i j k) (-> current (.split " ") map-int))
        (recur (list (rest query)) (conj I i) (conj JJ j) (conj K k))))))

(defn div-int [x y]
  (int (/ x y)))

(defn append-nth [lst i x]
  (assoc lst i (conj (nth lst i) x)))
(defn create-list [size init]
  (loop [[i 0]
         [res []]]
    (if (>= i size)
      res
      (do
        (.append res [])
        (recur (inc i) res)))))

(defn solve []
  ;; Parameters
  (setv (, N M) (-> data first (.split " ") map-int))
  (setv A (-> data second (.split " ") map-int))
  (setv (, I JJ K) (-> data (cut 2) convert-queries)) ;; sorry J is imaginary number ...
  ;; Main
  (setv nums (* [0] N)) ;; Aをソートしたもの
  (setv bucket (create-list (div-int +max-n+ +B+) []))
  (for [i (range N)]
    (append-nth bucket (div-int i +B+) (nth A i))
    (assoc nums i (nth A i)))
  (.sort nums)
  ;; B個に満たない最後のバケットをソートしていないが問題ない
  (for [i (range (div-int N +B+))]
    (.sort (nth bucket i)))
  (for [i (range M)]
    ;; [l, r)のk番目の数を求める
    (setv l (nth I i))
    ;(setv r (inc (nth JJ i))) ;; ??
    (setv r (nth JJ i))
    (setv k (nth K i))
    (setv lb -1)
    (setv ub (dec N))
    (while (> (- ub lb) 1)
      (setv md (div-int (+ lb ub) 2))
      (setv x (nth nums md))
      (setv tl l)
      (setv tr r)
      (setv c 0)
      ;; バケットをはみ出す部分
      (while (and (< tl tr) (not (zero? (% tl +B+))))
        (do
          (when (<= (nth A tl) x)
            (setv c (inc c)))
          (setv tl (inc tl))))
      (while (and (< tl tr) (not (zero? (% tr +B+))))
        (do
          (setv tr (dec tr))
          (when (<= (nth A tr) x)
            (setv c (inc c)))))
      ;; バケットごと
      (while (< tl tr)
        (setv b (div-int tl +B+))
        (setv current-bucket (nth bucket b))
        (setv index (upper-bound current-bucket x))
        ;(setv c (+ c (nth current-bucket index)))
        (setv c (+ c index))
        (setv tl (+ tl +B+)))
      (if (>= c k)
        (setv ub md)
        (setv lb md)))
    ;(print (nth nums ub)) ;; ??
    (print (dec (nth nums ub)))))

(defmain
  [&rest args]
  (solve))


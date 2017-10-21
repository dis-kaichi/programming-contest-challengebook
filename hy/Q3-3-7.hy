#!/usr/bin/env hy

;; ----------------------------------------
;; K-th Number 2
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [math [floor ceil]])

(def +st-size+ (dec (<< 1 18)))

(def data
  ["7 3"
   "1 5 2 6 3 7 4"
   "2 5 3"
   "4 4 1"
   "1 7 3"]) ;; 5 6 3

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

(defn create-list [size init]
  (loop [[i 0]
         [res []]]
    (if (>= i size)
      res
      (do
        (.append res [])
        (recur (inc i) res)))))

(defn double [x] (* x 2))
(defn half-int [x] (int (/ x 2)))

(defn append-nth [lst i x]
  (assoc lst i (conj (nth lst i) x)))

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn upper-bound [xs lower upper value]
  (loop [[lb lower ]
         [ub upper]]
    (if (<= (- ub lb) 1)
      ub
      (do
        (setv mid (truncate-div (+ lb ub) 2))
        (if (> (nth xs mid) value)
          (recur lb mid)
          (recur mid ub))))))

(defn init [dat A k l r]
  (if (= 1 (- r l))
    (append-nth dat k (nth A l))
    (do
      (setv lch (+ 1 (double k)))
      (setv rch (+ 2 (double k)))
      (init dat A lch l (half-int (+ l r)))
      (init dat A rch (half-int (+ l r)) r)
      ;; resize???
      (setv merged-list (+ (nth dat lch) (nth dat rch)))
      (.sort merged-list)
      (assoc dat k merged-list))))

(defn query [dat i j x k l r]
  (if (or (<= j l) (<= r i))
    0
    (if (and (<= i l) (<= r j))
      (upper-bound (nth dat k) 0 (len (nth dat k)) x)
      (do
        (setv lc (query dat i j x (+ 1 (double k)) l (half-int (+ l r))))
        (setv rc (query dat i j x (+ 2 (double k)) (half-int (+ l r)) r))
        (+ lc rc)))))

(defn solve []
  ;; Parameters
  (setv (, N M) (-> data first (.split " ") map-int))
  (setv A (-> data second (.split " ") map-int))
  (setv (, I JJ K) (-> data (cut 2) convert-queries)) ;; sorry J is imaginary number ...
  (setv nums (* [0] N)) ;; Aをソートしたもの
  (setv dat (create-list +st-size+ []))
  ;; Main
  (for [i (range N)]
    (assoc nums i (nth A i)))
  (.sort nums)

  (init dat A 0 0 N)

  (for [i (range M)]
    ;; [l, r)のk番目を探す
    (setv l (nth I i))
    ;(setv r (inc (nth JJ i))) ; ??
    (setv r (nth JJ i))
    (setv k (nth K i))

    (setv lb -1)
    (setv ub (dec N))
    (while (> (- ub lb) 1)
      (setv md (half-int (+ ub lb)))
      (setv c (query dat l r (nth nums md) 0 0 N))
      (if (>= c k)
        (setv ub md)
        (setv lb md)))
    ;(print (nth nums ub)) ; ??
    (print (dec (nth nums ub)))
    ))

(defmain
  [&rest args]
  (solve))


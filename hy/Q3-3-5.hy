#!/usr/bin/env hy

;; ----------------------------------------
;; A Simple Problem with Integers 2
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [math [floor]])

(def data
  ["8 2"
   "5 3 7 9 6 4 1 2"
   "C 1 5 1" ;; 1-indexed L and R
   "Q 1 5 0" ;;
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

(defn sum [b i]
  (setv s 0)
  (while (> i 0)
    (setv s (+ s (nth b i)))
    (setv i (- i (& i (- i)))))
  s)

(defn add [b N i v]
  (while (<= i N)
    (+= b i v)
    (setv i (+ i (& i (- i))))))

(def +max-n+ 1000)

(defn solve []
  ;; Parameters
  (setv (, N Q) (-> data first (.split " ") map-int))
  (setv A (-> data second (.split " ") map-int))
  (setv (, T L R X) (-> data (cut 2) list convert-queries))
  ;; convert 1-indexed
  (setv A (+ [0] A))
  ;; Main
  (setv bit0 (* [0] +max-n+))
  (setv bit1 (* [0] +max-n+))

  (for [i (range 1 (inc N))]
    (add bit0 N i (nth A i)))
  (for [i (range Q)]
    (if (= (nth T i) "C")
      (do
        (add bit0 N (nth L i) (- (* (nth X i) (dec (nth L i)))))
        (add bit1 N (nth L i) (nth X i))
        (add bit0 N (inc (nth R i)) (* (nth X i) (nth R i)))
        (add bit1 N (inc (nth R i)) (- (nth X i))))
      (do
        (setv res 0)
        (setv res (+ res (+ (sum bit0 (nth R i))
                            (* (sum bit1 (nth R i)) (nth R i)))))
        (setv res (- res (+ (sum bit0 (dec (nth L i)))
                            (* (sum bit1 (dec (nth L i))) (dec (nth L i))))))
        (print res)))))

(defmain
  [&rest args]
  (solve))


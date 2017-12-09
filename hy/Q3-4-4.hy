#!/usr/bin/env hy

;; ----------------------------------------
;; ドミノ敷き詰め
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-pipe ap-map-when]])
(import pdb)

(def data
  ["3 3"
   "..."
   ".x."
   "..."]) ;; 2

(def +m+ 100000) ;;

(def color {})

(defn map-int [xs] (list (map int xs)))

(defn conj [coll x]
  (+ coll [x]))

(defn str-to-colors [line]
  (loop [[xs (list line)]
         [colors []]]
    (if (zero? (len xs))
      colors
      (recur (-> xs rest list) (conj colors (= (first xs) "x"))))))

(defn convert-matrix [str-list]
  (loop [[lines str-list]
         [colors []]]
    (if (zero? (len lines))
      colors
      (recur (-> lines rest list)
             (conj colors (-> lines first str-to-colors))))))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defmacro += [var val]
  `(setv ~var (+ ~var ~val)))

(defn safe-get [-dict -key &optional [default False]]
  (try
    (get -dict -key)
    (except [e KeyError]
            default)))

;; 現在位置(i, j)で、既に敷き詰められたマスがused
(defn rec [n m colors i j used]
  (if (= j m)
    (rec n m colors (inc i) 0 used)
    (if (= i n)
      1
      (if (or (safe-get used i j)
              (nthm colors i j))
        (rec n m colors i (inc j) used)
        (do
          ;; 2通りの向きを試す
          (setv res 0)
          (assoc used (, i j) True)

          ;; 横向き
          (when (and (< (inc j) m)
                     (not (safe-get used (, i (inc j))))
                     (not (nthm colors i (inc j))))
            (assoc used (, i (inc j)) True)
            (+= res (rec n m colors i (inc j) used))
            (assoc used (, i (inc j)) False))

          ;; 縦向き
          (when (and (< (inc i) n)
                     (not (safe-get used (, (inc i) j)))
                     (not (nthm colors (inc i) j)))
            (assoc used (, (inc i) j) True)
            (+= res (rec n m colors (inc i) j  used))
            (assoc used (, (inc i) j) False))

          (assoc used (, i j) False)
          (% res +m+))))))

(defn solve []
  (setv (, n m) (-> data first (.split " ") map-int))
  (setv colors (-> data rest list convert-matrix))
  (setv used {})
  (print (rec n m colors 0 0 used))
  )
(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; 巡回セールスマン問題
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [math [floor ceil]])
(require [hy.extra.anaphoric [ap-pipe ap-map-when]])

(def +inf+ 1000000)

(def data
  ["5"
   "0 3 0 4 0"
   "0 0 5 0 0"
   "4 0 0 5 0"
   "0 0 0 0 3"
   "7 6 0 0 0"]) ;; 22 (0 -> 3 -> 4 -> 1 -> 2 -> 0)

(defn map-int [xs] (list (map int xs)))

(defn conj [coll x]
  (+ coll [x]))

(defn string-list-2-map [str-list]
  (loop [[lines str-list]
         [matrix []]]
    (if (zero? (len lines))
      matrix
      (recur (-> lines rest list)
             (conj matrix (map-int (-> lines first (.split " "))))))))

(defn convert-neighbor-matrix [matrix]
  (global +inf+)
  (loop [[rows matrix]
         [neighbor-matrix []]
         [index 0]]
    (if (zero? (len rows))
      neighbor-matrix
      (do
        (setv row (-> (ap-map-when zero? +inf+ (first rows)) list))   ;; 線が無い所はinf
        (assoc row index 0)                                           ;; 対角は0
        (recur (-> rows rest list)
               (conj neighbor-matrix row)
               (inc index)))))
    )

(def dp {})

(defn safe-get [-dict -key &optional [default -1]]
  (try
    (get -dict -key)
    (except [e KeyError]
            default)))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

;; すでに訪れた頂点がS, 現在位置がv
(defn rec [n d S v]
  (global dp)
  (if (>= (safe-get dp (, S v)) 0)
    (safe-get dp (, S v))
    (do
      (if (and (= S (dec (<< 1 n)))
               (= v 0))
        (do
          (assoc dp (, S v) 0)
          0)
        (do
          (setv res +inf+)
          (for [u (range n)]
            (when (not (& (>> S u) 1))
              (setv res (min res (+ (rec n d (| S (<< 1 u)) u)
                                    (nthm d v u))))))
          (assoc dp (, S v) res)
          res)))))

(defn solve []
  (setv n (-> data first int))
  (setv d (-> data rest list string-list-2-map convert-neighbor-matrix))
  (print (rec n d 0 0))
  )

(defmain
  [&rest args]
  (solve))


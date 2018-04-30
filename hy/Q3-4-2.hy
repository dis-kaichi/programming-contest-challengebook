#!/usr/bin/env hy

;; ----------------------------------------
;; 巡回セールスマン問題2
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [math [floor ceil]])
(require [hy.extra.anaphoric [ap-pipe ap-map-when]])

(setv +inf+ 1000000)

(setv data
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

(setv dp {})

;; 取得できない場合はinfを返す
(defn safe-get [-dict -key &optional [default +inf+]]
  (try
    (get -dict -key)
    (except [e KeyError]
            default)))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defn solve []
  (global dp)
  (setv n (-> data first int))
  (setv d (-> data rest list string-list-2-map convert-neighbor-matrix))
  ;;
  (assoc dp (, (dec (<< 1 n)) 0) 0)
  ;; 漸化式に従って順に計算
  (for [S (range (- (<< 1 n) 2) -1 -1)]
    (for [v (range n)]
      (for [u (range n)]
        (when (not (& (>> S u) 1))
          (assoc dp (, S v)
                 (min (safe-get dp (, S v))
                      (+ (safe-get dp (, (| S (<< 1 u)) u))
                         (nthm d v u))))))))
  (print (get dp (, 0 0))))

(defmain
  [&rest args]
  (solve))


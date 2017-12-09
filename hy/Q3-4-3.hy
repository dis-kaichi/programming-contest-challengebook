#!/usr/bin/env hy

;; ----------------------------------------
;; Traveling by Stagecoach
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [math [floor ceil]])
(require [hy.extra.anaphoric [ap-pipe ap-map-when]])

(def  data
  ["2 4 2 1"
   "3 1"
   "0 0 3 2"
   "0 0 3 5"
   "3 3 0 0"
   "2 5 0 0"]) ;; 3.667 (5 / 3 + 2 / 1)

(def +inf+ 1000000)

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

(defn convert-distance-matrix [matrix &optional [default -1]]
  (loop [[rows matrix]
         [new-matrix []]
         [index 0]]
    (if (zero? (len rows))
      new-matrix
      (do
        (setv row (-> (ap-map-when zero? default (first rows)) list))
        (recur (-> rows rest list)
               (conj new-matrix row)
               (inc index))))))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

;; dp[S][v]
;;  S : 残っている乗車券
;;  v : 現在位置vの状態に至るまでの最小のコスト
(def dp {})

(defn safe-get [-dict -key &optional [default +inf+]]
  (try
    (get -dict -key)
    (except [e KeyError]
            default)))

(defmacro in-set? [s i]
  `(& (>> ~s ~i) 1))

(defmacro remove-set [s i]
  `(& ~s (~ (<< 1 ~i))))

(defn solve []
  (global dp)
  (setv (, n m a b) (-> data first (.split " ") map-int))
  (setv t (-> data second (.split " ") map-int))
  (setv d (-> data rest rest list string-list-2-map convert-distance-matrix))
  ;;
  (assoc dp (, (dec (<< 1 n)) (dec a)) 0)
  (setv res +inf+)
  (for [S (range (dec (<< 1 n)) -1 -1)]
    (setv res (min res (safe-get dp (, S (dec b)))))
    (for [v (range m)]
      (for [i (range n)]
        (when (in-set? S i)
          (for [u (range m)]
            (when (>= (nthm d v u) 0)
              ;; 乗車券iを使って、vからuへの移動
              (assoc dp (, (remove-set S i) u)
                     (min (safe-get dp (, (remove-set S i) u))
                          (+ (safe-get dp (, S v))
                             (/ (* 1.0 (nthm d v u)) (nth t i)))))))))))
  (if (= res +inf+)
    (print "Impossible")
    (print (.format "{0:.3f}" res))))

(defmain
  [&rest args]
  (solve))


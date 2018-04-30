#!/usr/bin/env hy

;; ----------------------------------------
;; ドミノ敷き詰め2
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-pipe ap-map-when]])

(setv data
  ["3 3"
   "..."
   ".x."
   "..."]) ;; 2

(setv dp [{} {}])

(setv +m+ 100000) ;;

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

(defn safe-get [-dict -key &optional [default False]]
  (try
    (get -dict -key)
    (except [e KeyError]
            default)))

(defn safe-get-bool [d k]
  (safe-get d k False))

(defn safe-get-int [d k]
  (safe-get d k 0))

(defmacro in-set? [S i]
  `(& (>> ~S ~i) 1))

(defmacro remove-element [S i]
  `(& ~S (~ (<< 1 ~i))))

(defmacro += [var val]
  `(setv ~var (+ ~var ~val)))

(defmacro add-element [S i]
  `(| ~S (<< 1 ~i)))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defn solve []
  (global dp)
  (setv (, n m) (-> data first (.split " ") map-int))
  (setv colors (-> data rest list convert-matrix))
  ;;
  (setv (, crt next) [(nth dp 0) (nth dp 1)])
  (assoc crt 0 1)
  (for [i (range (dec n) -1 -1)]
    (for [j (range (dec m) -1 -1)]
      (for [used (range (<< 1 m))]
        (if (or (in-set? used j)
                (nthm colors i j))
          ; (i, j)にはブロックを置く必要が無い
          (assoc next used (safe-get-int crt (remove-element used j)))
          (do
            ;; 2通りの向きを試す
            (setv res 0)
            ; 横向き
            (when (and (< (inc j) m)
                       (not (in-set? used (inc j)))
                       (not (nthm colors i (inc j))))
              (+= res (safe-get-int crt (add-element used (inc j)))))
            ;; 縦向き
            (when (and (< (inc i) n)
                       (not (nthm colors (inc i) j)))
              (+= res (safe-get-int crt (add-element used j))))
            (assoc next used (% res +m+)))))
      (setv (, crt next) [next crt])))
  (print (safe-get-int crt 0)))


(defmain
  [&rest args]
  (solve))


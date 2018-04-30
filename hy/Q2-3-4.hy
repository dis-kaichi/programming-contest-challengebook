#!/usr/bin/env hy

;; ----------------------------------------
;; 最長共通部分列問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["4 4"
   "abcd"
   "becd"]) ;; bcd

(setv data
  ["6 5"
   "aebcd"
   "abecd"]) ;; aecd

(setv (, +n+ +m+) (-> data
                     (nth 0)
                     (.split " ")
                     ((fn [x] (map int x)))))
(setv +s+ (-> data (nth 1) list))
(setv +t+ (-> data (nth 2) list))

(defn create-matrix [n m]
  (list (map list (partition (* [0] (* n m)) m))))

(defn setm! [matrix  row col value]
  (assoc (get matrix row) col value))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(setv *dp* (create-matrix (inc +n+) (inc +m+)))

(defn solve []
  (for [i (range +n+)]
    (for [j (range +m+)]
      (if (= (nth +s+ i) (nth +t+ j))
        (setm! *dp* (inc i) (inc j) (inc (nthm *dp* i j)))
        (setm! *dp* (inc i) (inc j) (max (nthm *dp* i (inc j))
                                         (nthm *dp* (inc i) j))))))
  (print (nthm *dp* +n+ +m+)))

(defmain
  [&rest args]
  (solve))



#!/usr/bin/env hy

;; ----------------------------------------
;; 個数制限なしナップサック問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["3 7"
   "3 4 4 5 2 3"])

(setv (, +n+ +W+) (-> (nth data 0)
                     (.split " ")
                     ((fn [x] (map int x)))))
(setv (, +ws+ +vs+) (-> (nth data 1)
                       (.split " ")
                       ;; 数値化
                       ((fn [x] (map int x)))
                       ;; iterator => list
                       list
                       ;; 先頭から2個組を作る
                       partition
                       ;; iterator => list
                       list
                       ;; 2個組の1つ目だけの配列と2つ目だけの配列を作成
                       ((fn [x] (, (map first x) (map second x))))
                       ;; iterator => list
                       ((fn [x] (map list x)))))

(defn create-matrix [n m]
  (list (map list (partition (* [0] (* n m)) m))))
(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(setv *dp* (create-matrix (inc +n+) (inc +W+)))

(defn solve []
  (for [i (range +n+)]
    (for [j (range (inc +W+))]
      (if (< j (nth +ws+ i))
        (setm! *dp* (inc i) j (nthm *dp* i j))
        (setm! *dp* (inc i) j
               (max (nthm *dp* i j)
                    (+ (nthm *dp* (inc i) (- j (nth +ws+ i)))
                       (nth +vs+ i)))))))
  (print (nthm *dp* +n+ +W+)))

(defmain
  [&rest args]
  (solve))



#!/usr/bin/env hy

;; ----------------------------------------
;; 01ナップサック問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["4 5"
   "2 3 1 2 3 4 2 2"])

(def (, +n+ +W+) (-> (nth data 0)
                     (.split " ")
                     ((fn [x] (map int x)))))
(def (, +ws+ +vs+) (-> (nth data 1)
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
  (list (map list (partition (* [-1] (* n m)) m))))
(defn setm! [matrix  row col value]
  (let [x (nth matrix row)]
    (assoc x col value)))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(def *dp* (create-matrix (inc +n+) (inc +W+)))

(defn rec [i j]
  (if (>= (nthm *dp* i j) 0)
    (nthm *dp* i j)
    (if (= i +n+)
      (do
        (setm! *dp* i j 0)
        0)
      (if (< j (nth +ws+ i))
        (do
          (setv x (rec (inc i) j))
          (setm! *dp* i j x)
          x)
        (do
          (setv x (max [(rec (inc i) j)
                        (+ (rec (inc i) (- j (nth +ws+ i)))
                           (nth +vs+ i))]))
          (setm! *dp* i j x)
          x)))))

(defn solve []
  (print (rec 0 +W+)))

(defmain
  [&rest args]
  (solve))



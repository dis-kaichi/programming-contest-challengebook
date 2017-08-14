#!/usr/bin/env hy

;; ----------------------------------------
;; 01ナップサック問題その2
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["3 7"
   "3 4 4 5 2 3"]) ; 9

(def data
  ["4 5"
   "2 3 1 2 3 4 2 2"]) ; 7

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

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))
(defn setm! [matrix  row col value]
  (let [x (nth matrix row)]
    (assoc x col value)))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(def +inf+ 10000)
(def +dp-col+ (inc (* +n+ (max +vs+))))
(def *dp* (create-matrix (inc +n+) +dp-col+ +inf+))
(setm! *dp* 0 0 0) ;; dp[0][0] = 0

(defn solve []
  (for [i (range +n+)]
    (for [j (range +dp-col+)]
      (if (< j (nth +vs+ i))
        (setm! *dp* (inc i) j (nthm *dp* i j))
        (setm! *dp* (inc i) j (min (nthm *dp* i j)
                                   (+ (nthm *dp* i (- j (nth +vs+ i)))
                                      (nth +ws+ i)))))))
  (print (loop [[i 0]
                [res 0]]
           (if (>= i +dp-col+)
             res
             (if (<= (nthm *dp* +n+ i) +W+)
               (recur (inc i) i)
               (recur (inc i) res))))))

(defmain
  [&rest args]
  (solve))


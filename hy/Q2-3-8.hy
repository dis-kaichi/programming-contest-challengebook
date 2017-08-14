#!/usr/bin/env hy

;; ----------------------------------------
;; 個数制限なしナップサック問題(1次元配列Ver)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["3 7"
   "3 4 4 5 2 3"])

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

(def *dp* (* [0] (inc +W+)))

(defn solve []
  (for [i (range +n+)]
    (for [j (range (nth +ws+ i) (inc +W+))]
      (assoc *dp* j (max (nth *dp* j)
                         (+ (nth *dp* (- j (nth +ws+ i)))
                            (nth +vs+ i))))))
  (print (nth *dp* +W+)))

(defmain
  [&rest args]
  (solve))



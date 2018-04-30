#!/usr/bin/env hy

;; ----------------------------------------
;; 01ナップサック問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["4 5"
   "2 3 1 2 3 4 2 2"])

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
(defn rec [i j]
  (if (= i +n+)
    0
    (if (< j (nth +ws+ i))
      (rec (inc i) j)
      (max [(rec (inc i) j)
            (+ (rec (inc i) (- j (nth +ws+ i))) (nth +vs+ i))]))))
(defn solve []
  (print (rec 0 +W+)))

(defmain
  [&rest args]
  (solve))


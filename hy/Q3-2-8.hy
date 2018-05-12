#!/usr/bin/env hy

;; ----------------------------------------
;; 巨大ナップサック
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [lib.search [lower-bound]])

(setv data
  ["4"
   "2 1 2 3"
   "3 2 4 2"
   "5"]) ;; 7

(defn map-int [x]
  (list (map int x)))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv w (-> data (nth 1) (.split " ") map-int))
  (setv v (-> data (nth 2) (.split " ") map-int))
  (setv W (-> data (nth 3) int))
  ;; Main
  (setv ps [])
  (setv n2 (// n 2))
  (for [i (range (<< 1 n2))]
    (setv (, sw sv) [0 0])
    (for [j (range n2)]
      (when (& (>> i j) 1)
        (+= sw (nth w j))
        (+= sv (nth v j))))
    (.append ps [sw sv]))
  ;; 無駄な要素を取り除く
  (.sort ps #* [] #** {"key" first})
  (setv m 1)
  (for [i (range 1 (<< 1 n2))]
    (when (< (second (nth ps (dec m)))
             (second (nth ps i)))
      (assoc ps m (nth ps i))
      (+= m 1)))

  ;; 後ろ半分を全列挙し解を求める
  (setv first-pss (list (map first ps)))
  (loop [[i 0]
         [res 0]]
    (if (>= i (<< 1 (- n n2)))
      (print res)
      (do
        (setv (, sw sv) [0 0])
        (for [j (range (- n n2))]
          (when (& (>> i j) 1)
            (+= sw (nth w (+ n2 j)))
            (+= sv (nth v (+ n2 j)))))
        (if (<= sw W)
          (do
            (setv index (-> first-pss (lower-bound (- W sw) 0 m) dec))
            (if (neg? index)
              (recur (inc i) res)
              (do
                (setv tv (-> ps (nth index) second))
                (recur (inc i) (max res (+ sv tv))))))
          (recur (inc i) res))))))

(defmain
  [&rest args]
  (solve))


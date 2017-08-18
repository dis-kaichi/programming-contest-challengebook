#!/usr/bin/env hy

;; ----------------------------------------
;; Lake Counting
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["10 12"
   "W........WW."
   ".WWW.....WWW"
   "....WW...WW."
   ".........WW."
   ".........W.."
   "..W......W.."
   ".W.W.....WW."
   "W.W.W.....W."
   ".W.W......W."
   "..W.......W."
   ])

(def +NM+ (list (map int (.split (nth data 0)))))
(def +N+ (nth +NM+ 0))
(def +M+ (nth +NM+ 1))
(def field (list (map list (cut data 1))))
(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defn dfs [x y]
  (setm! field x y ".")
  (for [dx (range -1 2)]
    (for [dy (range -1 2)]
      (def nx (+ x dx))
      (def ny (+ y dy))
      (when (and (<= 0 nx)
                 (< nx +N+)
                 (<= 0 ny)
                 (< ny +M+)
                 (= (nthm field nx ny) "W"))
        (dfs nx ny)
      ))))

(defn solve []
  (def res 0)
  (for [i (range 0 +N+)]
    (for [j (range 0 +M+)]
      (when (= (nthm field i j) "W")
        (dfs i j)
        (def res (inc res)))))
  (print res))

(defmain
  [&rest args]
  (solve))


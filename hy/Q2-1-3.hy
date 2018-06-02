#!/usr/bin/env hy

;; ----------------------------------------
;; Lake Counting
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["10 12" ;; 3
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

(setv +NM+ (list (map int (.split (nth data 0)))))
(setv +N+ (nth +NM+ 0))
(setv +M+ (nth +NM+ 1))
(setv field (list (map list (cut data 1))))

(defn dfs [x y]
  (setv (get field x y) ".")
  (for [dx (range -1 2)]
    (for [dy (range -1 2)]
      (setv nx (+ x dx))
      (setv ny (+ y dy))
      (when (and (<= 0 nx)
                 (< nx +N+)
                 (<= 0 ny)
                 (< ny +M+)
                 (= (get field nx ny) "W"))
        (dfs nx ny)
      ))))

(defn solve []
  (setv res 0)
  (for [i (range 0 +N+)]
    (for [j (range 0 +M+)]
      (when (= (get field i j) "W")
        (dfs i j)
        (setv res (inc res)))))
  (print res))

(defmain
  [&rest args]
  (solve))


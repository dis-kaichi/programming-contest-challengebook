#!/usr/bin/env hy

;; ----------------------------------------
;; 区間スケジューリング
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["5"
   "1 2 4 6 8"
   "3 5 7 9 10"])
(def +N+ (int (nth data 0)))
(def +S+ (list (map int (.split (nth data 1)))))
(def +T+ (list (map int (.split (nth data 2)))))

(defclass Pair []
  [f 0
   s 0]
  (defn --init-- [self f s]
    (setv self.f f)
    (setv self.s s)))

(def ITV [])

(defn solve []
  (for [i (range +N+)]
    (.append ITV (Pair (nth +T+ i) (nth +S+ i))))
  ;;(print (list (map (fn [p] p.f) ITV)))
  (apply ITV.sort [] {"key" (fn [x] x.f)})
  ;;(print (list (map (fn [p] p.f) ITV)))
  (loop[[ans 0]
        [t 0]
        [i 0]]
    (if (< i +N+)
      (if (< t (. (nth ITV i) s))
        (recur (inc ans) (. (nth ITV i) f) (inc i))
        (recur ans t (inc i)))
      (print (.format "{0:d}" ans)))))

(defmain
  [&rest args]
  (solve))


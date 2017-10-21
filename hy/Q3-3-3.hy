#!/usr/bin/env hy

;; ----------------------------------------
;; バブルソートの交換回数
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["4"
   "3 1 4 2"]) ;; 3

(defn map-int [xs] (list (map int xs)))

(defmacro += [xs i value] `(assoc ~xs ~i (+ (nth ~xs ~i) ~value)))

(defn sum [bit i]
  (loop [[s 0]
         [index i]]
    (if (<= index 0)
      s
      (do
        (recur (+ s (nth bit index))
               (- index (& index (- index))))))))
(defn add [bit n i x]
  (while (<= i n)
    (+= bit i x)
    (setv i (+ i (& i (- i))))))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv a (-> data second (.split " ") map-int))
  ;; Main
  (setv bit (* [0] (inc n)))
  (setv ans 0)
  (for [j (range n)]
    (setv ans (+ ans (- j (sum bit (nth a j)))))
    (add bit n (nth a j) 1))
  (print ans)
  )


(defmain
  [&rest args]
  (solve))


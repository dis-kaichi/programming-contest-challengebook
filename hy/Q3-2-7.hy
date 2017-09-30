#!/usr/bin/env hy

;; ----------------------------------------
;; 4 Values whose Sum is 0
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["6"
   "-45 -41 -36 -36 26 -32"
   "22 -27 53 30 -38 -54"
   "42 56 -37 -75 -10 -6"
   "-16 30 77 -46 62 45"]) ;; 5

(defn map-int [x]
  (list (map int x)))

(defmacro += [variable value]
  `(setv ~variable (+ ~variable ~value)))

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn lower-bound [xs value]
  (loop [[lb 0]
         [ub (len xs)]]
    (if (<= (- ub lb) 1)
      ub
      (do
        (setv mid (truncate-div (+ lb ub) 2))
        (if (>= (nth xs mid) value)
          (recur lb mid)
          (recur mid ub))))))

(defn solve []
  ;; Parameters
  (setv n (-> data first int))
  (setv A (-> data (nth 1) (.split " ") map-int))
  (setv B (-> data (nth 2) (.split " ") map-int))
  (setv C (-> data (nth 3) (.split " ") map-int))
  (setv D (-> data (nth 4) (.split " ") map-int))
  ;; Main
  (setv CD (* [0] (* n n))) ;; CとDの組からの取り出し方
  (for [i (range n)]
    (for [j (range n)]
      (assoc CD (+ (* i n) j) (+ (nth C i) (nth D j)))))
  (.sort CD)
  (setv res 0)
  (for [i (range n)]
    (for [j (range n)]
      (setv cd (- (+ (nth A i) (nth B j))))
      ;; CとDから和がcdとなるように取り出す
      (setv ii (lower-bound CD cd))
      (when (zero? (- (nth CD ii) cd))
        (+= res 1))))
  (print res))

(defmain
  [&rest args]
  (solve))


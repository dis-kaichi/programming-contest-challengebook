#!/usr/bin/env hy

;; ----------------------------------------
;; Face The Right Way
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-if]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(setv data
  ["7"
   "BBFBFBB"]) ;; (3, 3)

(setv +max-n+ 5000)
(setv *f* (* [0] +max-n+))

(defn non-neg? [x]
  (or (zero? x)
      (pos? x)))

(defmacro subst-with-op [op variable value]
  `(setv ~variable (~op ~variable ~value)))

(defn calc [N dir K]
  (for [i (range (len *f*))]
    (assoc *f* i 0))
  (loop [[res 0]
         [sum 0]
         [i 0]]
    (if (<= i (- N K))
      (do
        (when (odd? (+ (nth dir i) sum))
          (setv res (inc res))
          (assoc *f* i 1))
        (subst-with-op + sum (nth *f* i))
        (if (non-neg? (- i K -1))
          (recur res (- sum (nth *f* (- i K -1))) (inc i))
          (recur res sum (inc i))))
      (if (< i N)
        (if (odd? (+ (nth dir i) sum))
          -1
          (if (non-neg? (- i K -1))
            (recur res (- sum (nth *f* (- i K -1))) (inc i))
            (recur res sum (inc i))))
        res))))

;; for文多用Ver
;(defn calc [N dir K]
;  (for [i (range (len *f*))]
;    (assoc *f* i 0))
;  (setv res 0)
;  (setv sum 0)
;  (for [i (range (inc (- N K)))]
;    (when (odd? (+ (nth dir i) sum))
;      (setv res (inc res))
;      (assoc *f* i 1))
;    (setv sum (+ sum (nth *f* i)))
;    (when (non-neg? (- i K -1))
;      (setv sum (- sum (nth *f* (- i K -1))))))
;  (for [i (range (- N K -1) N)]
;    (if (odd? (+ (nth dir i) sum))
;      (do
;        (setv res -1)
;        (break))
;      (when (non-neg? (- i K -1))
;        (setv sum (- sum (nth *f* (- i K -1)))))))
;  res)

(defn str-to-dir [x]
  (if (= x "F")
    0
    1))

(defn solve []
  ;; Parameters
  (setv N (-> data first int))
  (setv dir (-> data second list ((partial map str-to-dir)) list))
  ;; Main
  (loop [[K 1]
         [M N]
         [k 1]]
    (if (> k N)
      (print K M)
      (do
        (setv m (calc N dir k))
        (if (and (>= m 0) (> M m))
          (recur k m (inc k))
          (recur K M (inc k)))))))

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; 探索
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

;; 二分探索
;;  xs      : list
;;  x       : element
;;  return  : True/False (Founded/Not)
(defn binary-search [xs x]
  (loop [[l 0]
         [r (len xs)]]
    (if (< (- r l) 1)
      False
      (do
        (setv i (// (+ l r) 2))
        (if (= x (nth xs i))
          True
          (if (< (nth xs i) x)
            (recur (inc i) r)
            (recur l i)))))))

;; lower-bound, upper-bound
;;  http://www.pandanoir.info/entry/2015/12/26/190000
(defn lower-bound [xs value &optional [lower 0] [upper -1]]
  (when (empty? xs)
    (return 0))

  (when (= -1 upper)
    (setv upper (len xs)))

  (setv mid 0)
  (while (> (- upper lower) 1)
    (setv mid (// (+ lower upper) 2))
    (if (< (get xs mid) value)
      (setv lower mid)
      (setv upper mid)))
  (if (< (get xs lower) value)
    upper
    lower))

(defn upper-bound [xs value &optional [lower 0] [upper -1]]
  (when (empty? xs)
    (return 0))

  (when (= -1 upper)
    (setv upper (len xs)))

  (setv mid 0)
  (while (> (- upper lower) 1)
    (setv mid (// (+ lower upper) 2))
    (if (<= (get xs mid) value)
      (setv lower mid)
      (setv upper mid)))
  (if (<= (get xs lower) value)
    upper
    lower))

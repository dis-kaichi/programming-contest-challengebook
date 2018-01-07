#!/usr/bin/env hy

;; ----------------------------------------
;; 探索
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

;; 二分探索
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

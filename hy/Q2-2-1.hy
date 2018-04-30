#!/usr/bin/env hy

;; ----------------------------------------
;; 硬貨の問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [math [floor]])

(setv data
  ["3 2 1 3 0 2 620"])

(setv +raw+ (list (map int (.split (nth data 0)))))
(setv +C+ (list (take 6 +raw+)))
(setv +A+ (nth +raw+ 6))
(setv +V+ [1 5 10 50 100 500])

(defn solve []
  (loop [[i 5]
         [ans 0]
         [tmp-a +A+]]
    (if (>= i 0)
      (do
        (setv t (min (floor (/ tmp-a (nth +V+ i))) (nth +C+ i)))
        (recur (dec i) (+ ans t) (- tmp-a (* t (nth +V+ i))))
        )
      (print (.format "{0:d}" (int ans))))))

(defmain
  [&rest args]
  (solve))

#!/usr/bin/env hy

;; ----------------------------------------
;; 硬貨の問題
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [math [floor]])

(def data
  ["3 2 1 3 0 2 620"])

(def +raw+ (list (map int (.split (nth data 0)))))
(def +C+ (list (take 6 +raw+)))
(def +A+ (nth +raw+ 6))
(def +V+ [1 5 10 50 100 500])

(defn solve []
  (loop [[i 5]
         [ans 0]
         [tmp-a +A+]]
    (if (>= i 0)
      (do
        (def t (min (floor (/ tmp-a (nth +V+ i))) (nth +C+ i)))
        (recur (dec i) (+ ans t) (- tmp-a (* t (nth +V+ i))))
        )
      (print (.format "{0:d}" (int ans))))))

(defmain
  [&rest args]
  (solve))

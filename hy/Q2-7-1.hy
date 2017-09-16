#!/usr/bin/env hy

;; ----------------------------------------
;; Minimum Scalar Product
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["3"
   "1 3 -5"
   "-2 4 1"]) ;; -25
;(def data
;  ["5"
;   "1 2 3 4 5"
;   "1 0 1 0 1"]) ;; 6

(defn solve []
  (setv n (-> data first int))
  (setv v1 (-> data (nth 1) (.split " ") ((partial map int)) list))
  (setv v2 (-> data (nth 2) (.split " ") ((partial map int)) list))
  (.sort v1)
  (.sort v2)
  (loop [[i 0]
         [ans 0]]
    (if (>= i n)
      (print ans)
      (recur (inc i) (+ ans
                        (* (nth v1 i)
                           (nth v2 (- n i 1))))))))

(defmain
  [&rest args]
  (solve))


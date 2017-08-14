#!/usr/bin/env hy

;; ----------------------------------------
;; 個数制限付き部分和問題(Ver2)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["3 17"
   "3 5 8"
   "3 2 2"])

(def (, +n+ +K+) (-> data
                     (nth 0)
                     (.split " ")
                     ((partial map int))))
(def +a+ (-> data
             (nth 1)
             (.split " ")
             ((partial map int))
             list)) ;; iterator -> list

(def +m+ (-> data
             (nth 2)
             (.split " ")
             ((partial map int))
             list)) ;; iterator -> list

(def *dp* (* [-1] (inc +K+)))
(assoc *dp* 0 0)

(defn solve []
  (for [i (range +n+)]
    (for [j (range (inc +K+))]
      (if (>= (nth *dp* j) 0)
        (assoc *dp* j (nth +m+ i))
        (if (or (< j (nth +a+ i))
                (<= (nth *dp* (- j (nth +a+ i))) 0))
          (assoc *dp* j -1)
          (assoc *dp* j (dec (nth *dp* (- j (nth +a+ i)))))))))
  (if (>= (nth *dp* +K+) 0)
    (print "Yes")
    (print "No")))

(defmain
  [&rest args]
  (solve))


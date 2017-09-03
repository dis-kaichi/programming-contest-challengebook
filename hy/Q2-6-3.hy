#!/usr/bin/env hy

;; ----------------------------------------
;; 素数判定
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(defn prime? [n]
  (loop [[i 2]]
    (if (> (pow i 2) n)
      (!= (% n i) 1)
      (if (zero? (% n i))
        False
        (recur (inc i))))))

(defn truncate-div [n d]
  (setv c (/ n d))
  (if (> c 0)
    (floor c)
    (ceil c)))

(defn divisor [n]
  (loop [[i 1]
         [res []]]
    (if (> (pow i 2) n)
      res
      (if (zero? (% n i))
        (if (!= i (truncate-div n i))
          (recur (inc i) (+ res [i (truncate-div n i)]))
          (recur (inc i) (+ res [i])))
        (recur (inc i) res)))))

(defn get-safe [dict index default]
  (try
    (get dict index)
    (except [e Exception]
            default)))

(defn  prime-factor [m]
  (loop [[i 2]
         [n m]
         [res {}]]
    (if (> (pow i 2) m)
      (do
        (when (!= n 1)
          (assoc res n 1))
        res)
      (if (zero? (% n i))
        (do
          (assoc res i (inc (get-safe res i 0)))
          (recur i (truncate-div n i) res))
        (recur (inc i) n res)))))


(defn solve []
  (print (prime? 53))       ;; True
  (print (prime? 295927))   ;; False
  (print (divisor 295927))
  (print (prime-factor 295927)))

(defmain
  [&rest args]
  (solve))

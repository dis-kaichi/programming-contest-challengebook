#!/usr/bin/env hy

;; Ants (POJ No.1852)

(def data
  ["10"
   "3"
   "2 6 7"])

(def +L+ (int (nth data 0)))
(def +n+ (int (nth data 1)))
(def +x+ (list (map int (.split (nth data 2)))))

(defn calc-min-time-core [xs min-t]
  (if (empty? xs)
    min-t
    (do
      (def xi (first xs))
      (calc-min-time-core
        (list (rest xs))
        (max min-t (min xi (- +L+ xi)))))))

(defn calc-max-time-core [xs max-t]
  (if (empty? xs)
    max-t
    (do
      (def xi (first xs))
      (calc-max-time-core
        (list (rest xs))
        (max max-t (max xi (- +L+ xi)))))))

(defn solve []
  (print (calc-min-time-core +x+ 0)
         (calc-max-time-core +x+ 0)))

(defmain
  [&rest args]
  (solve))


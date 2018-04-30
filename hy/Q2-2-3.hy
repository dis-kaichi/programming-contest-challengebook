#!/usr/bin/env hy

;; ----------------------------------------
;; Best Cow Line
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["6"
   "ACDBCB"])

(setv +N+ (int (nth data 0)))
(setv +S+ (list (map list (nth data 1))))

(defn solve-core [a b]
  (loop [[i 0]]
    (setv sa (nth +S+ (+ a i)))
    (setv sb (nth +S+ (- b i)))
    (if (<= (+ a i) b)
      (if (< sa sb)
        True
        (when (> sa sb)
          False))
      (recur (inc i))
      False)))

(defn solve []
  (loop [[a 0]
         [b (dec +N+)]
         [ans []]
         ]
    (if (<= a b)
      (if (solve-core a b)
        (recur (inc a) b (+ ans (nth +S+ a)))
        (recur a (dec b) (+ ans (nth +S+ b))))
      (print (.join "" ans)))
    )
  )

(defmain
  [&rest args]
  (solve)
  )


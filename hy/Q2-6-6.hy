#!/usr/bin/env hy

;; ----------------------------------------
;; Carmichael Numbers
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])
;(import [lib.algebra [mod-pow]])
(import [lib.algebra [mod-pow-v2 :as mod-pow]])

(defn prime? [n]
  (loop [[i 2]]
    (if (> (pow i 2) n)
      (!= (% n i) 1)
      (if (zero? (% n i))
        False
        (recur (inc i))))))


(defn carmicheal-number? [n]
  (if (prime? n)
    False
    (loop [[i 2]
           [flag True]]
      (if(not flag)
        False
        (if (>= i n)
          True
          (recur (inc i) (= i (mod-pow i n n))))))))

(defn yes-or-no [flag]
  (if flag
    (print "Yes")
    (print "No")))

(defn solve []
  (yes-or-no (carmicheal-number? 561))
  (yes-or-no (carmicheal-number? 17))
  (yes-or-no (carmicheal-number? 4)))

(defmain
  [&rest args]
  (solve))


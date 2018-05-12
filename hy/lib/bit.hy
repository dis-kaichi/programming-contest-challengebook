#!/usr/bin/env hy

(import [operations [safe-get]])

(setv *n* (** 10 5))
(setv *bit* {})

(defn set-n [n]
  (global *n*)
  (setv *n* n))

(defn sum [i]
  (setv s 0)
  (while (pos? i)
    (+= s (safe-get *bit* i 0))
    (-= i (& i (- i))))
  s)

(defn add [i x]
  (while (<= i *n*)
    (assoc *bit* i (+ (safe-get *bit* i 0) x))
    (setv i (+ i (& i (- i))))))


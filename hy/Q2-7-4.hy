#!/usr/bin/env hy

;; ----------------------------------------
;; Millionaire
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])
(def data
  ["1 0.5 500000"]) ;; 0.500000

(def data
  ["3 0.75 600000"]) ;; 0.843750

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(def +max-m+ 5) ;; Small
(def *dp* (create-matrix 2 (inc (<< 1 +max-m+))))

(defn nthm [matrix row col]
  (-> matrix
      (nth row)
      (nth col)))

(defn solve []
  (setv (, M P X) (-> data
                      first
                      (.split " ")
                      (->> (zip [int float int]))
                      list
                      ((partial map (fn [(, func value)]
                                      (apply func [value]))))
                      list))
  ;; Solve Main
  (setv n (<< 1 M)) ;; 左Shift(倍化)
  (setv (, prv nxt) [(nth *dp* 0) (nth *dp* 1)])
  (for [i (range (+ n 2))]
    (assoc prv i 0.0)
    (assoc nxt i 0.0))
  (assoc prv n 1.0)

  (for [r (range M)]
    (for [i (range (inc n))]
      (setv jub (min i (- n i)))
      (setv t 0.0)
      (for [j (range (inc jub))]
        (setv t (max t (+ (* P (nth prv (+ i j)))
                          (* (- 1 P) (nth prv (- i j)))))))
      (assoc nxt i t))
    ;; Swap
    (setv tmp prv)
    (setv prv nxt)
    (setv nxt tmp)
    )
  (setv i (* X (/ n 1000000)))
  (print (nth prv (int i))))

(defmain
  [&rest args]
  (solve))


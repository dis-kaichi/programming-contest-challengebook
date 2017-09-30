#!/usr/bin/env hy
;; ----------------------------------------
;; Physics Experiment
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-if ap-pipe]])
(import [functools [partial]])
(import [math [floor sqrt pow]])


(def data
  ["1 10 10 100"]) ;; 4.95
(def data
  ["2 10 10 100"]) ;; 4.95 10.20

(defn map-int [x]
  (list (map int x)))

(def +g+ 10.0) ;; 重力加速度

(defn calc [H T]
  (if (< T 0)
    H
    (do
      (setv t (sqrt (/ (* 2 H) +g+)))
      (setv k (floor (/ T t)))
      (if (even? k)
        (do
          (setv d (- T (* k t)))
          (- H (/ (* +g+ d d) 2)))
        (do
          (setv d (+ (* k t) (- t T)))
          (- H (/ (* +g+ d d) 2)))))))

(defn solve []
  ;; Parameters
  (setv (, N H R T) (-> data first (.split " ") map-int))
  ;; Main
  (setv y (* [0] N)) ;; 最終的なボールの位置
  (for [i (range N)]
    (assoc y i (calc H (- T i))))
  (.sort y)
  (setv answers [])
  (for [i (range N)]
    (.append answers (.format "{0:.2f}"
                              (+ (nth y i) (/ (* 2 R i) 100.0)))))
  (print (.join " " answers)))

(defmain
  [&rest args]
  (solve))


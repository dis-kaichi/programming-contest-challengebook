#!/usr/bin/env hy

;; ----------------------------------------
;; 食物連鎖
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["100 7"
   "1 101 1" ;; invalid
   "2 1 2"
   "2 2 3"
   "2 3 3"   ;; invalid
   "1 1 3"   ;; invalid
   "2 3 1"
   "1 5 5"]) ;; 3

(def (, +N+ +K+) (-> data
                     (nth 0)
                     (.split " ")
                     ((partial map int))))

(defn str-to-int-list [s]
  (-> s
      (.split " ")
      ((partial map int))
      list))

(defn third [lst]
  (nth lst 2))

(defn triples-to-lists [lst]
  (, (-> lst
         ((partial map first))
         list)
     (-> lst
         ((partial map second))
         list)
     (-> lst
         ((partial map third))
         list)))

(def (, +T+ +X+ +Y+) (-> data
                         (cut 1)
                         ((partial map str-to-int-list))
                         list
                         triples-to-lists))

(def +max-n+ 10000)
(def *parent* (* [0] +max-n+))
(def *rank* (* [0] +max-n+))

(defn init [n]
  (for [i (range n)]
    (assoc *parent* i i)
    (assoc *rank* i 0)))

(defn find [x]
  (if (= (nth *parent* x) x)
    x
    (do
      (assoc *parent* x (find (nth *parent* x)))
      (nth *parent* x))))

(defn unite [x y]
  (setv x (find x))
  (setv y (find y))
  (when (not (= x y))
    (if (< (nth *rank* x) (nth *rank* y))
      (assoc *parent* x y)
      (do
        (assoc *parent* y x)
        (when (= (nth *rank* x) (nth *rank* y))
          (assoc *rank* x (inc (nth *rank* x))))))))

(defn same [x y]
  (= (find x) (find y)))

(defn solve []
  (init (* 3 +N+))
  (loop [[i 0]
         [ans 0]]
    (if (>= i +K+)
      (print ans)
      (do
        (setv t (nth +T+ i))
        (setv x (dec (nth +X+ i)))
        (setv y (dec (nth +Y+ i)))
        (if (or (< x 0)
                (<= +N+ x)
                (< y 0)
                (<= +N+ y))
          (recur (inc i) (inc ans))
          (if (= t 1)
            (if (and (same x (+ y +N+))
                     (same x (+ y (* +N+ 2))))
              (recur (inc i) (inc ans))
              (do
                (unite x y)
                (unite (+ x +N+) (+ y +N+))
                (unite (+ x (* +N+ 2)) (+ y (* +N+ 2)))
                (recur (inc i) ans)))
            (if (or (same x y)
                    (same x (+ y (* 2 +N+))))
              (recur (inc i) (inc ans))
              (do
                (unite x (+ y +N+))
                (unite (+ x +N+) (+ y (* 2 +N+)))
                (unite (+ x (* +N+ 2)) y)
                (recur (inc i) ans)))))))))

(defmain
  [&rest args]
  (solve))


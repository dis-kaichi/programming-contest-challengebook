#!/usr/bin/env hy

;; ----------------------------------------
;; Conscription
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]])

(def data
  ["5 5 8"    ;; N, M, R
   "4 3 6831" ;; x, y, d
   "1 3 4583"
   "0 0 6592"
   "0 1 3063"
   "3 3 4975"
   "1 3 2049"
   "4 2 2104"
   "2 2 781"]) ;; 71071

(defclass Edge []
  [_u 0
   _v 0
   _cost 0]
  (defn --init-- [self u v cost]
    (setv (. self _u) u)
    (setv (. self _v) v)
    (setv (. self _cost) cost))
  (defn --lt-- [self other]
    (> (. self _cost) (. other _cost)))
  (defn --le-- [self other]
    (>= (. self _cost) (. other _cost)))
  (defn --gt-- [self other]
    (< (. self _cost) (. other _cost)))
  (defn --ge-- [self other]
    (<= (. self _cost) (. other _cost)))
  (defn --str-- [self]
    (.format "{0} {1} {2}"
             (. self _u) (. self _v) (. self _cost)))
  #@(property (defn u [self]))
  #@(u.getter (defn u [self] (. self _u)))
  #@(property (defn v [self]))
  #@(v.getter (defn v [self] (. self _v)))
  #@(property (defn cost [self]))
  #@(cost.getter (defn cost [self] (. self _cost))))

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defn append-list [lst1 lst2]
  (+ lst1 [lst2]))

;; ----------------------------------------
;; Union-Find木
;; ----------------------------------------
(def +union-find-max+ 10000)
(def *parent* (* [0] +union-find-max+))
(def *rank* (* [0] +union-find-max+))

(defn init-union-find [n]
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
;; ----------------------------------------
;; End
;; ----------------------------------------

(def (, +N+ +M+ +R+)
  (-> data
      first
      (.split " ")
      ((partial map int))))

(def *x* (* [0] +R+))
(def *y* (* [0] +R+))
(def *d* (* [0] +R+))

(def *es* [])

(def (, +V+ +E+) [(+ +N+ +M+) +R+])

(defn kruskal []
  ;; 小さい順にソート
  (setv sorted-es (-> *es*
                      ((fn [lst]
                         (apply sorted [lst] {"reverse" True})))))
  (init-union-find +V+)
  (loop [[i 0]
         [res 0]]
    (if (>= i +E+)
      res
      (do
        (setv e (nth sorted-es i))
        (if (not (same (. e u) (. e v)))
          (do
            (unite (. e u) (. e v))
            (recur (inc i) (+ res (. e cost))))
          (recur (inc i) res))))))

(defn solve []
  ;; データの設定
  (setv lines (-> data rest list))
  (for [i (range +R+)]
    (setv (, x y d) (-> lines
                        (nth i)
                        (.split " ")
                        ((partial map int))))
    (assoc *x* i x)
    (assoc *y* i y)
    (assoc *d* i d))
  ;;
  (for [i (range +R+)]
    (.append *es* (Edge (nth *x* i)
                        (+ +N+ (nth *y* i))
                        (- (nth *d* i)))))
  (print (+ (* 10000 (+ +N+ +M+)) (kruskal))))

(defmain
  [&rest args]
  (solve))

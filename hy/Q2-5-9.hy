#!/usr/bin/env hy

;; ----------------------------------------
;; 最小全域木問題２(クラスカル法)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [lib.unionfind [init-union-find unite same]])

(setv data
  ["7 18"  ;; 辺数は無向グラフなので２倍にする
   "0 1 2" ;; from to cost
   "0 2 10"
   "1 3 7"
   "1 5 3"
   "1 6 1"
   "2 3 5"
   "3 4 8"
   "3 5 1"
   "4 5 5"]) ;; cost 17

(setv data
  ["8 22"  ;; 辺数は無向グラフなので２倍にする
   "0 1 2" ;; from to cost
   "0 2 10"
   "1 3 7"
   "1 5 3"
   "1 6 1"
   "2 3 5"
   "3 4 8"
   "3 5 1"
   "4 5 5"
   "6 7 3"
   "1 7 2"]) ;; cost 19

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

(setv (, +V+ +E+) (-> data first (.split " ") ((partial map int))))

(defn str-data-to-list [raw-info-list]
  (loop [[info-list raw-info-list]
         [data []]]
    (if (empty? info-list)
      data
      (do
        (setv (, from to cost) (-> info-list
                                   first
                                   (.split " ")
                                   ((partial map int))))
        (recur (-> info-list rest list)
               (+ data [(Edge from to cost)
                        (Edge to from cost)]))))))

(setv *es* (-> data rest list str-data-to-list))

(defn kruskal []
  ;; 小さい順にソート
  (setv sorted-es (-> *es*
                      ((fn [lst]
                         (sorted #* [lst] #** {"reverse" True})))))
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
  (print (kruskal)))

(defmain
  [&rest args]
  (solve))


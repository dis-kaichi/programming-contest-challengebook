#!/usr/bin/env hy

;; ----------------------------------------
;; 最短路問題(Bellman-Ford法; negative-loop)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(defclass Edge []
  [_from 0
   _to 0
   _cost 0]

  (defn --init-- [self from to cost]
    (setv (. self _from) from)
    (setv (. self _to) to)
    (setv (. self _cost) cost))

  #@(property
  (defn from[self]))
  #@(from.setter
  (defn from[self from]
    (setv (. self _from) from)))
  #@(from.getter
  (defn from[self]
    (. self _from)))
  #@(property
  (defn to[self]))
  #@(to.setter
  (defn to[self to]
    (setv (. self _to) to)))
  #@(to.getter
  (defn to[self]
    (. self _to)))
  #@(property
  (defn cost[self]))
  #@(cost.setter
  (defn cost[self cost]
    (setv (. self _cost) cost)))
  #@(cost.getter
  (defn cost[self]
    (. self _cost)))

  (defn --str-- [self]
    (.format "{0} {1} {2}" (. self _from) (. self _to) (. self _cost))))

(setv data
  ["7 20" ;; vertexs edges(無向グラフなので2倍する)
   ;; A(0) ... G(6)
   "0 1 2" ;; from to cost
   "0 2 5"
   "1 2 4"
   "1 3 6"
   "1 4 10"
   "2 3 2"
   "3 5 1"
   "4 5 3"
   "4 6 5"
   "5 6 9"]) ;; マイナス値が無いのでFalse

(setv data
  ["7 20" ;; vertexs edges(無向グラフなので2倍する)
   ;; A(0) ... G(6)
   "0 1 2" ;; from to cost
   "0 2 1"
   "1 2 4"
   "1 3 6"
   "1 4 10"
   "2 3 1"
   "3 5 1"
   "4 5 3"
   "4 6 5"
   "5 6 -1"]) ;; マイナス値があるのでTrue

(setv (, +V+ +E+) (-> data
                     first
                     (.split " ")
                     ((partial map int))))

(defn append-list [lst1 lst2]
  (+ lst1 [lst2]))

(defn read-str-graph [edge-str-list]
  (loop [[remain-edges edge-str-list]
         [graph []]]
    (if (<= (len remain-edges) 0)
      graph
      (recur (-> remain-edges
                 rest
                 list)
             (-> remain-edges
                 first
                 (.split " ")
                 ((partial map int))
                 list
                 ((partial append-list graph)))))))

(defn reverse-edge [edge]
  [(-> edge (nth 1))
   (-> edge (nth 0))
   (-> edge (nth 2))])

(defn append-reverse-edges [edges]
  (+ edges
     (-> edges
         ((partial map reverse-edge))
         list)))

(defn value-of-edge [lst]
  (Edge #* lst))

(defn create-edges [edges]
  (-> edges
      ((partial map value-of-edge))
      list))

(setv *es* (-> data
              (cut 1)
              list
              read-str-graph
              append-reverse-edges
              create-edges))

(setv *d* (* [0] +V+))

(defn find-negative-loop []
  (for [i (range +V+)]
    (assoc *d* i 0))
  (loop [[i 0]
         [j 0]]
    (if (>= i +V+)
      False
      (if (>= j +E+)
        (recur (inc i) 0)
        (do
          (setv e (nth *es* j))
          (if (> (nth *d* (. e to))
                 (+ (nth *d* (. e from))
                    (. e cost)))
            (do
              (assoc *d* (. e to) (+ (nth *d* (. e from)) (. e cost)))
              (if (= i (dec +V+))
                True
                (recur i (inc j))))
            (recur i (inc j))))))))

(defn solve []
  (print (find-negative-loop))
  )

(defmain
  [&rest args]
  (solve))


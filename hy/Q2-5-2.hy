#!/usr/bin/env hy

;; ----------------------------------------
;; 最短路問題(Bellman-Ford法)
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

(def data
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
   "5 6 9"])

(def (, +V+ +E+) (-> data
                     first
                     (.split " ")
                     ((partial map int))))

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))
(defn setm! [matrix  row col value]
  (let [x (nth matrix row)]
    (assoc x col value)))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

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
  (apply Edge lst))

(defn create-edges [edges]
  (-> edges
      ((partial map value-of-edge))
      list))

(def *es* (-> data
              (cut 1)
              list
              read-str-graph
              append-reverse-edges
              create-edges))

(def *d* (* [0] +V+))

(def +inf+ 100000)

(defn shortest-path [s]
  (for [i (range +V+)]
    (assoc *d* i +inf+))
  (assoc *d* s 0)
  (loop [[flag True]]
    (if (not flag)
      ""
      (do
        (setv update False)
        (for [i (range +E+)]
          (setv e (nth *es* i))
          (when (and (!= (nth *d* (. e from)) +inf+)
                     (> (nth *d* (. e to))
                        (+ (nth *d* (. e from)) (. e cost))))
            (assoc *d* (. e to) (+ (nth *d* (. e from))
                                   (. e cost)))
            (setv update True)))
        (recur update)))))

(defn solve []
  (shortest-path 0)
  (print *d*))

(defmain
  [&rest args]
  (solve))


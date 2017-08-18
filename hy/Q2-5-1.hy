#!/usr/bin/env hy

;; ----------------------------------------
;; 二部グラフ判定
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(def data
  ["3" ;; vertex
   "0 1"
   "0 2"
   "1 2"]) ;; No

(def data
  ["4" ;; vertex
   "0 1"
   "1 2"
   "2 3"
   "0 3"]) ;; Yes

(def data
  ["4" ;; vertex
   "0 1"
   "0 2"
   "0 3"
   "1 2"
   "2 3"]) ;; No

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))
(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))
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

(def +V+ (-> data first int))

(defn create-empty-lists [n]
  (loop [[i 0]
         [matrix []]]
    (if (>= i n)
      matrix
      (recur (inc i) (append-list matrix [])))))

(defn create-graph-matrix [edges]
  (loop [[remain-edges edges]
         [matrix (create-empty-lists +V+)]]
    (if (<= (len remain-edges) 0)
      matrix
      (do
        (setv (, start end) (first remain-edges))
        (.append (nth matrix start) end)
        (.append (nth matrix end) start)
        (recur (-> remain-edges rest list) matrix)))))

(def *G* (-> data
             (cut 1)
             list
             read-str-graph
             create-graph-matrix))

(def *color* (* [0] +V+))

(defn dfs [v c]
  (assoc *color* v c)
  (setv size (-> *G* (nth v) len))
  (loop [[i 0]]
    (if (>= i size)
      True
      (if (= c (-> *color* (nth (nthm *G* v i))))
        False
        (if (and (= 0 (-> *color* (nth (nthm *G* v i))))
                 (not (dfs (nthm *G* v i) (- c))))
          False
          (recur (inc i)))))))

(defn solve []
  (loop [[i 0]]
    (if (>= i +V+)
      (print "Yes")
      (if (= 0 (-> *color* (nth i)))
        (if (not (dfs i 1))
          (print "No")
          (recur (inc i)))
        (recur (inc i))))))

(defmain
  [&rest args]
  (solve))


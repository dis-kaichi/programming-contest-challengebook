#!/usr/bin/env hy

;; ----------------------------------------
;; 単一始点最短路問題２（ダイクストラ法２）
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]])

(setv data
  ["7 20"
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

(setv (, +V+ +E+) (-> data
                     first
                     (.split " ")
                     ((partial map int))))

(defclass Edge []
  [_to 0
   _cost 0]

  (defn --init-- [self to cost]
    (setv (. self _to) to)
    (setv (. self _cost) cost))

  #@(property
  (defn to [self]))
  #@(to.getter
  (defn to [self]
    (. self _to)))
  #@(property
  (defn cost [self]))
  #@(cost.getter
  (defn cost [self]
    (. self _cost)))
  (defn --str-- [self]
    (.format "{0} {1}" (. self _to) (. self _cost))))

(setv +inf+ 1000000)

(setv *G*
  (loop [[i 0]
         [lst []]]
    (if (>= i +V+)
      lst
      (recur (inc i) (+ lst [[]])))))

(setv *que* [])

(setv *d* (* [0] +V+))

(defn appendm! [matrix row value]
  ;; 指定行に値を追加する
  (.append (nth matrix row) value))

(defn value-of-edge-tuple [raw-line &optional [reverse False]]
  (setv (, from to cost) (map int (.split raw-line " ")))
  (if reverse
    [to (Edge from cost)]
    [from (Edge to cost)]))

(defn insert-matrix [matrix edge-tuple]
  (setv (, from edge) edge-tuple)
  (appendm! matrix from edge))

(defn parse-and-insert [lines]
  (for [line lines]
    (-> line
        value-of-edge-tuple
        ((partial insert-matrix *G*)))
    (-> line
        (value-of-edge-tuple True)
        ((partial insert-matrix *G*)))))


(defn heap-push [x]
  (heappush *que* x))
(defn heap-pop []
  (heappop *que*))
(defn empty-que? []
  (empty? *que*))

(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defn dijkstra [s]
  (for [i (range +V+)]
    (assoc *d* i +inf+))
  (assoc *d* s 0)
  (heap-push [0 s])
  (loop []
    (if (empty-que?)
      ""
      (do
        (setv (, distance vertex) (heap-pop))
        (if (< (nth *d* vertex) distance)
          (recur)
          (do
            (for [i (range (len (nth *G* vertex)))]
              (setv edge (nthm *G* vertex i))
              (when (> (nth *d* (. edge to))
                       (+ (nth *d* vertex)
                          (. edge cost)))
                (assoc *d* (. edge to) (+ (nth *d* vertex) (. edge cost)))
                (heap-push [(nth *d* (. edge to)) (. edge to)])))
            (recur)))))))

(defn solve []
  ;; データを配列に入れる
  (-> data
      (cut 1)
      list
      parse-and-insert)
  ;; Dijkstra
  (dijkstra 0)
  (print *d*))

(defmain
  [&rest args]
  (solve))


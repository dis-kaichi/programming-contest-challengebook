#!/usr/bin/env hy

;; ----------------------------------------
;; Roadblocks
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]])

(def data
  ["4 4"
   ;; A(0) ... G(6)
   "0 1 100"
   "1 2 250"
   "1 3 200"
   "2 3 100"])

(def (, +N+ +R+) (-> data
                     first
                     (.split " ")
                     ((partial map int))))

(def +E+ (* 2 +R+)) ;; 無向グラフなので辺数を２倍にする

(defclass Edge []
  [_to 0
   _cost 0]

  (defn --init-- [self to cost]
    (setv (. self _to) to)
    (setv (. self _cost) cost))

  #@(property (defn to [self]))
  #@(to.getter (defn to [self] (. self _to)))
  #@(property (defn cost [self]))
  #@(cost.getter (defn cost [self] (. self _cost)))
  (defn --str-- [self]
    (.format "{0} {1}" (. self _to) (. self _cost))))

(def +inf+ 1000000)

(def *G*
  (loop [[i 0]
         [lst []]]
    (if (>= i +N+)
      lst
      (recur (inc i) (+ lst [[]])))))

(def *que* [])

(def *dist* (* [0] +N+))  ;; 最短距離
(def *dist2* (* [0] +N+)) ;; ２番目の最短距離

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

(defn solve []
  ;; データを配列に入れる
  (-> data
      (cut 1)
      list
      parse-and-insert)
  ;; 計算
  (for [i (range +N+)]
    (assoc *dist* i +inf+)
    (assoc *dist2* i +inf+))
  (assoc *dist* 0 0)
  (heap-push [0 0])
  (loop []
    (if (empty-que?)
      (print (nth *dist2* (dec +N+)))
      (do
        (setv (, d v) (heap-pop))
        (if (< (nth *dist2* v) d)
          (recur)
          (do
            (for [i (range (len (nth *G* v)))]
              (setv e (nthm *G* v i))
              (setv d2 (+ d (. e cost)))
              (when (> (nth *dist* (. e to)) d2)
                ;; swap
                (setv d-to (nth *dist* (. e to)))
                (assoc *dist* (. e to) d2)
                (setv d2 d-to)
                (heap-push [(nth *dist* (. e to)) (. e to)]))
              (when (and (> (nth *dist2* (. e to)) d2)
                         (< (nth *dist* (. e to)) d2))
                (assoc *dist2* (. e to) d2)
                (heap-push [(nth *dist2* (. e to)) (. e to)])))
            (recur)))))))

(defmain
  [&rest args]
  (solve))


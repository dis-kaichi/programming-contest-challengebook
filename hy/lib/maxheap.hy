#!/usr/bin/env hy

;; ----------------------------------------
;; Max Heap : ルートが最大値
;; ----------------------------------------
(import [heapq [heappush heappop]])

;; heapqはデフォルトだとmin-heapしか対応していないので
;; max-heapを実現するために逆順になるクラスを利用する
;;   min-heap : ルートが最小値 (heapq)
;;   max-heap : ルートが最大値
(defclass ReverseOrder []
  []
  (defn --init-- [self x]
    (setv (. self _x) x))
  (defn --lt-- [self other]
    (> (. self _x) (. other _x)))
  (defn --le-- [self other]
    (>= (. self _x) (. other _x)))
  (defn --gt-- [self other]
    (< (. self _x) (. other _x)))
  (defn --ge-- [self other]
    (<= (. self _x) (. other _x)))
  (defn --str-- [self]
    (-> (. self _x) str)))

(defn heap-push [que x]
  (heappush que (ReverseOrder x)))

(defn heap-pop [que]
  (. (heappop que) _x))

#!/usr/bin/env hy

;; ----------------------------------------
;; ヒープ木ライブラリ(heapq)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]])

;; heapqはデフォルトだとmin-heapしか対応していないので
;; max-heapを実現するために逆順になるクラスを利用する
;;   min-heap : ルートが最小値
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

(defn solve []
  (print "======================")
  (print "max-heap")
  (print "======================")
  (setv pque [])
  (heap-push pque 3)
  (heap-push pque 5)
  (heap-push pque 1)
  (loop [[que pque]]
    (try
      (do
        (print (nth que 0))      ;; pop without delete
        (setv x (heap-pop que))  ;; pop with delete
        (print x)
        (recur que))
      (except [e IndexError]
              "")))
  ;;
  (print "======================")
  (print "min-heap")
  (print "======================")
  (heappush pque 3)
  (heappush pque 5)
  (heappush pque 1)
  (loop [[que pque]]
    (try
      (do
        (print (nth que 0))     ;; pop without delete
        (setv x (heappop que))  ;; pop with delete
        (print x)
        (recur que))
      (except [e IndexError]
              "")))
  )

(defmain
  [&rest args]
  (solve))


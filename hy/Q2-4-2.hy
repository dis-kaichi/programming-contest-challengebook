#!/usr/bin/env hy

;; ----------------------------------------
;; ヒープ木ライブラリ(heapq)
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]]) ;; min-heap
(import [lib.maxheap [heap-push heap-pop]])

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


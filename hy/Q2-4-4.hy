#!/usr/bin/env hy

;; ----------------------------------------
;; Fence Repair
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]])


(setv data
  ["3"
   "8 5 8"]) ;; 34

(setv data
  ["4"
   "8 5 9 10"]) ;; 64

(setv +N+ (-> data (nth 0) int))
(setv +L+ (-> data
             (nth 1)
             (.split " ")
             ((partial map int))
             list))

(defn solve []
  ;; min-heapで実装する
  (setv que [])
  (for [i (range +N+)]
    (heappush que (nth +L+ i)))
  (loop [[size (len que)]
         [ans 0]]
    (if (<= size 1)
      (print ans)
      (do
        (setv l1 (heappop que))
        (setv l2 (heappop que))
        (heappush que (+ l1 l2))
        (recur (len que) (+ ans l1 l2))))))

(defmain
  [&rest args]
  (solve))


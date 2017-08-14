#!/usr/bin/env hy

;; ----------------------------------------
;; Expedition
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [heapq [heappush heappop]])

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

(def data
  ["4 25 10"
   "10 14 20 21"
   "10 5 2 4"])
(def (, +N+ +L+ +P+) (-> data
                         (nth 0)
                         (.split " ")
                         ((partial map int))))
(def *A* (-> data
             (nth 1)
             (.split " ")
             ((partial map int))
             list))

(def *B* (-> data
             (nth 2)
             (.split " ")
             ((partial map int))
             list))

(defn solve []
  (.append *A* +L+)
  (.append *B* 0)
  (setv size (inc +N+))

  (setv que [])
  (loop [[i 0]
         [ans 0]
         [pos 0]
         [tank +P+]]
    (if (>= i size)
      (print ans)
      (do
        (setv d (- (nth *A* i) pos))
        (if (< (- tank d) 0)
          (if (empty? que)
            (recur size -1 pos tank)
            (recur i (inc ans) pos (+ tank (heap-pop que))))
          (do
            (heap-push que (nth *B* i))
            (recur (inc i) ans (nth *A* i) (- tank d))))))))

(defmain
  [&rest args]
  (solve))


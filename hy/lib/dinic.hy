#!/usr/bin/env hy

;; ----------------------------------------
;; Dinic法
;; ----------------------------------------
(import sys)
(require [hy.contrib.loop [loop]])
(import [operations [safe-get]])

(setv +inf+ (. sys maxsize))

(defclass Edge []
  [-to 0
   -cap 0
   -rev 0]

  (defn --init-- [self to cap rev]
    (setv (. self -to) to)
    (setv (. self -cap) cap)
    (setv (. self -rev) rev))

  #@(property (defn to [self]))
  #@(to.getter (defn to [self] (. self -to)))
  #@(to.setter (defn to [self to] (setv (. self -to) to)))

  #@(property (defn cap [self]))
  #@(cap.getter (defn cap [self] (. self -cap)))
  #@(cap.setter (defn cap [self cap] (setv (. self -cap) cap)))

  #@(property (defn rev [self]))
  #@(rev.getter (defn rev [self] (. self -rev)))
  #@(rev.setter (defn rev [self rev] (setv (. self -rev) rev)))

  (defn --str-- [self]
    (.format "{0} {1} {2}" (. self -to) (. self -cap) (. self -rev))))

(setv G {})      ;; グラフの隣接リスト表現

(defn push [-list element]
  (.append -list element)
  -list)

(defn add-edge [from to cap]
  (assoc G from (push (safe-get G from [])
                      (Edge to cap (len (safe-get G to [])))))
  (assoc G to (push (safe-get G to [])
                    (Edge from 0 (dec (len (safe-get G from [])))))))

;; sからの最短距離をBFSで計算する
(defn bfs [level s]
  (setv que [])
  (assoc level s 0)
  (.append que s)
  (while (not (empty? que))
    (setv v (first que))
    (.pop que 0)
    (for [i (range (len (safe-get G v [])))]
      (setv e (get G v i))
      (when (and (> (. e cap) 0)
                 (< (safe-get level (. e to) -1) 0))
        (assoc level (. e to) (inc (get level v)))
        (.append que (. e to))))))

;; 増加パスをDFSで探す
(defn dfs [iter level v t f]
  (if (= v t)
    f
    (do
      (setv d 0)
      (for [i (range (safe-get iter v 0) (len (safe-get G v [])))]
        (setv e (get G v i))
        (when (and (> (. e cap) 0)
                   (< (safe-get level v -1) (safe-get level (. e to) -1)))
          (setv d (dfs iter level (. e to) t (min f (. e cap))))
          (when (> d 0)
            (-= (. e cap) d)
            (+= (. (get G (. e to) (. e rev)) cap) d)
            (break))))
      d)))

;; sからtへの最大流を求める
(defn max-flow [s t]
  (loop [[flow 0]]
    (setv level {}) ;; sからの距離
    (bfs level s)
    (if (< (safe-get level t -1) 0)
      flow
      (do
        (setv iter {}) ;; どこまで調べおわったか
        (setv new-flow flow)
        (while True
          (setv f (dfs iter level s t +inf+))
          (if (> f 0)
            (+= new-flow f)
            (break)))
        (recur new-flow)))))

;; グラフのクリア
(defn clear-graph []
  (setv G {}))


#!/usr/bin/env hy

;; ----------------------------------------
;; Ford-Fullkerson法
;; ----------------------------------------
(import sys)
(require [hy.contrib.loop [loop]])
(import [operations [safe-get push]])

(def +inf+ (. sys maxsize))

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
    (.format "{0} {1} {2}" (. self -to) (. self -cap) (. self -rev)))
  )

(def G {})      ;; グラフの隣接リスト表現
(def used {})   ;; DFSで既に調べたかのフラグ

(defn add-edge [from to cap]
  (assoc G from (push (safe-get G from []) (Edge to cap (len (safe-get G to [])))))
  (assoc G to (push (safe-get G to []) (Edge from 0 (dec (len (safe-get G from [])))))))

;; 増加パスをDFSで探す
(defn dfs [v t f]
  (global used)
  (global G)
  (if (= v t)
    f
    (do
      (assoc used v True)
      (setv d 0)
      (for [i (range (len (safe-get G v [])))]
        (setv e (get G v i))
        (if (and (not (safe-get used (. e to) False))
                 (> (. e cap ) 0))
          (do
            (setv d (dfs (. e to) t (min f (. e cap))))
            (when (> d 0)
              (do
                (-= (. e cap) d)
                (+= (. (get G (. e to) (. e rev)) cap) d)
                (break))))))
      d)))

;; sからtへの最大流を求める
(defn max-flow [s t]
  (loop [[flow 0]]
    (global used)
    (setv used {})
    (setv f (dfs s t +inf+))
    (if (zero? f)
      flow
      (recur (+ f flow)))))

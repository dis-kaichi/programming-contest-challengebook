#!/usr/bin/env hy

;; ----------------------------------------
;; 最小費用流
;; ----------------------------------------

(import sys)
(import [operations [safe-get push]])
(setv +inf+ (. sys maxsize))

(defclass Edge []
  [-to 0
   -cap 0
   -rev 0]

  (defn --init-- [self to cap cost rev]
    (setv (. self -to) to)
    (setv (. self -cap) cap)
    (setv (. self -cost) cost)
    (setv (. self -rev) rev))

  #@(property (defn to [self]))
  #@(to.getter (defn to [self] (. self -to)))
  #@(to.setter (defn to [self to] (setv (. self -to) to)))

  #@(property (defn cap [self]))
  #@(cap.getter (defn cap [self] (. self -cap)))
  #@(cap.setter (defn cap [self cap] (setv (. self -cap) cap)))

  #@(property (defn cost [self]))
  #@(cost.getter (defn cost [self] (. self -cost)))
  #@(cost.setter (defn cost [self cost] (setv (. self -cost) cost)))

  #@(property (defn rev [self]))
  #@(rev.getter (defn rev [self] (. self -rev)))
  #@(rev.setter (defn rev [self rev] (setv (. self -rev) rev)))

  (defn --str-- [self]
    (.format "{0} {1} {2} {3}"
             (. self -to) (. self -cap) (. self -cost) (. self -rev))))

(setv G {})      ;; グラフの隣接リスト表現
(setv dist {})   ;; 最短距離

;; fromからtoへ向かう容量cap, コストの辺をグラフに追加する
(defn add-edge [from to cap cost]
  (assoc G from (push (safe-get G from [])
                      (Edge to cap cost (len (safe-get G to [])))))
  (assoc G to (push (safe-get G to [])
                    (Edge from 0 (- cost)
                          (dec (len (safe-get G from [])))))))

(defn get-dist [x]
  (safe-get dist x +inf+))

;; sからtへの流量fの最小費用流を求める
;; 流せない場合は-1を返す
(defn min-cost-flow [V s t f]
  (global dist)
  (setv prevv (* [0] V))  ;; 直前の頂点
  (setv preve (* [0] V))  ;; 直前の辺
  (setv res 0)
  (while (> f 0)
    ;; ベルマンフォード法により、s-t間最短路を求める
    (setv dist {})
    (assoc dist s 0)
    (setv update True)
    (while update
      (setv update False)
      (for [v (range V)]
        (when (= (get-dist v) +inf+)
          (continue))
        (for [i (range (len (safe-get G v [])))]
          (setv e (get G v i))
          (when (and (pos? (. e cap))
                     (> (get-dist (. e to))
                        (+ (get-dist v) (. e cost))))
            (assoc dist (. e to) (+ (get-dist v) (. e cost)))
            (assoc prevv (. e to) v)
            (assoc preve (. e to) i)
            (setv update True)))))
    (if (= (get-dist t) +inf+)
      ;; これ以上流せない
      (do
        (setv res -1)
        (break))
      (do
        ;; s-t間最短路に従って目一杯流す
        (setv d f)
        ;;
        (setv v t)
        (while (not (= v s))
          (setv d (min d (. (get G (get prevv v) (get preve v)) cap)))
          (setv v (get prevv v)))
        (-= f d)
        (+= res (* d (get-dist t)))
        ;;
        (setv v t)
        (while (not (= v s))
          (setv e (get G (get prevv v) (get preve v)))
          (-= (. e cap) d)
          (+= (. (get G v (. e rev)) cap) d)
          (setv v (get prevv v))))))
  res)

(defn get-graph []
  G)

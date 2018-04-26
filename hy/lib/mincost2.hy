#!/usr/bin/env hy

;; ----------------------------------------
;; 最小費用流2
;; ----------------------------------------

(import sys)
(import [operations [safe-get push]])
;(import [maxheap [heap-push heap-pop]])
(import [heapq [heappush heappop]])
(def +inf+ (. sys maxsize))

(defclass Edge []
  [-to 0
   -cap 0
   -cost 0
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

(def G {})    ;; グラフの隣接リスト表現
(def dist {})   ;; 最短距離

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
  (setv h {})    ;; ポテンシャル
  (while (> f 0)
    ;; ダイクストラ法を用いてhを更新する
    (setv que [])
    (setv dist {})
    (assoc dist s 0)
    (heappush que [0 s])
    (while (not (empty? que))
      (setv p (heappop que))
      (setv v (second p))
      (when (< (get-dist v) (first p))
        (continue))
      (for [i (range (len (safe-get G v [])))]
        (setv e (get G v i))
        (when (and (pos? (. e cap))
                   (> (get-dist (. e to))
                      (+ (get-dist v)
                         (. e cost)
                         (safe-get h v 0)
                         (- (safe-get h (. e to) 0)))))
          (assoc dist (. e to)
                 (+ (get-dist v)
                    (. e cost)
                    (safe-get h v 0)
                    (- (safe-get h (. e to) 0))))
          (assoc prevv (. e to) v)
          (assoc preve (. e to) i)
          (heappush que [(get-dist (. e to)) (. e to)]))))
    (when (= (get-dist t) +inf+)
      (setv f -1)
      (setv que [])
      (setv res -1)
      (continue))
    (for [v (range V)]
      (assoc h v (+ (safe-get h v 0) (get-dist v))))
    ;; s-t間最短路に沿って目一杯流す
    (setv d f)
    ;;
    (setv v t)
    (while (not (= v s))
      (setv d (min d (. (get G (get prevv v) (get preve v)) cap)))
      (setv v (get prevv v)))
    (-= f d)
    ;(+= res (* d (get-dist t)))
    (+= res (* d (safe-get h t 0)))
    ;;
    (setv v t)
    (while (not (= v s))
      (setv e (get G (get prevv v) (get preve v)))
      (-= (. e cap) d)
      (+= (. (get G v (. e rev)) cap) d)
      (setv v (get prevv v))))
  res)

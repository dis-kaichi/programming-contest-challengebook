#!/usr/bin/env hy

;; ----------------------------------------
;; Evacuation
;; ----------------------------------------
(import [lib.bipartite [bipartite-matching add-edge clear-graph]])
(import [lib.inpututils [split-with-space map-int]])
(import [lib.operations [safe-get]])
(import [lib.queue [Queue]])

(defn C [t dX dY pX pY dist]
  (setv d (len dX))
  (setv p (len pX))

  ;; 0~d-1  : 時刻1に対応するドア
  ;; d~2d-1 : 時刻2に対応するドア
  ;;
  ;; (t-1)d~td-1 : 時刻tに対応するドア
  ;; td~td+p-1  : 人
  (setv V (+ (* t d) p))
  (clear-graph)

  (for [i (range d)]
    (for [j (range p)]
      (setv cur-dist (safe-get dist (, (nth dX i)
                                       (nth dY i)
                                       (nth pX j)
                                       (nth pY j))
                               -1))
      (when (>= cur-dist 0)
        (for [k (range cur-dist (inc t))]
          (add-edge (+ (* (dec k) d) i) (+ (* t d) j))))))
  (= (bipartite-matching V) p))

;; BFSで最短距離を求める
(defn bfs [x y dx dy X Y dist dist-x dist-y field]
  (setv qx (Queue))
  (setv qy (Queue))
  (assoc dist (, dist-x dist-y x y) 0)
  (.push qx x)
  (.push qy y)
  (while (not (.empty? qx))
    (setv x (.pop qx))
    (setv y (.pop qy))
    (for [k (range 4)]
      (setv x2 (+ x (nth dx k)))
      (setv y2 (+ y (nth dy k)))
      (when (and (<= 0 x2)
                 (< x2 X)
                 (<= 0 y2)
                 (< y2 Y)
                 (= (get field x2 y2) ".")
                 (< (safe-get dist (, dist-x dist-y x2 y2) -1) 0))
        (assoc dist (, dist-x dist-y x2 y2)
               (inc (safe-get dist (, dist-x dist-y x y) -1)))
        (.push qx x2)
        (.push qy y2)))))

(defn solve []
  ;; Paramters

  ;;; Answer : 3
  (setv (, X Y) (, 5 5))
  (setv field (-> ["XXDXX"
                   "X...X"
                   "D...X"
                   "X...D"
                   "XXXXX"]
                  ((fn [x] (map list x)))
                  list))
  ;;;; Answer : 21
  ;(setv (, X Y) (, 5 12))
  ;(setv field (-> ["XXXXXXXXXXXX"
  ;                 "X..........D"
  ;                 "X.XXXXXXXXXX"
  ;                 "X..........X"
  ;                 "XXXXXXXXXXXX"]
  ;                ((fn [x] (map list x)))
  ;                list))
  ;;;; Answer : 1
  ;(setv (, X Y) (, 3 3))
  ;(setv field (-> ["XXX"
  ;                 "X.D"
  ;                 "XXX"]
  ;                ((fn [x] (map list x)))
  ;                list))

  ;; Main
  (setv dx [-1 0 0 1])
  (setv dy [0 -1 1 0])

  (setv dX [])
  (setv dY [])

  (setv pX [])
  (setv pY [])

  (setv dist {})

  (setv n (* X Y))

  ;; 各ドアからの最短距離を求める
  (for [x (range X)]
    (for [y (range Y)]
      (cond [(= (get field x y) "D")
             (do
               (.append dX x)
               (.append dY y)
               (bfs x y dx dy X Y dist x y field))]
            [(= (get field x y) ".")
             (do
               (.append pX x)
               (.append pY y))])))

  ;; 二分探索により全員が脱出可能な最小の時間tを求める
  (setv (, lb ub) (, -1 (inc n)))
  (while (> (- ub lb) 1)
    ;;(setv mid (// (+ lb ub) 2))
    (setv mid (round (/ (+ lb ub) 2)))
    (if (C mid dX dY pX pY dist)
      (setv ub mid)
      (setv lb mid)))

  (if (> ub n)
    ;; 脱出不能
    (print "impossible")
    (print ub))
  )

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; Evacuation2
;; ----------------------------------------
(import [lib.bipartite [dfs add-edge clear-match clear-used]])
(import [lib.inpututils [split-with-space map-int]])
(import [lib.operations [safe-get]])
(import [lib.queue [Queue]])

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
  ;;; Answer : 21
  (setv (, X Y) (, 5 12))
  (setv field (-> ["XXXXXXXXXXXX"
                   "X..........D"
                   "X.XXXXXXXXXX"
                   "X..........X"
                   "XXXXXXXXXXXX"]
                  ((fn [x] (map list x)))
                  list))
  ;;; Answer : impossible
  (setv (, X Y) (, 5 5))
  (setv field (-> ["XDXXX"
                   "X.X.D"
                   "XX.XX"
                   "D.X.X"
                   "XXXDX"]
                  ((fn [x] (map list x)))
                  list))
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

  ;; グラフを作成
  (setv (, d p) (, (len dX) (len pX)))
  (for [i (range d)]
    (for [j (range p)]
      (setv cur-dist (safe-get dist (, (nth dX i)
                                       (nth dY i)
                                       (nth pX j)
                                       (nth pY j))
                               -1))
      (when (>= cur-dist 0)
        (for [k (range cur-dist (inc n))]
          (add-edge (+ (* (dec k) d) i) (+ (* n d) j))))))

  ;; 全員が脱出するための最小時間を計算
  (if (zero? p)
    (print 0)
    (do
      (setv num 0)
      (clear-match)
      (for [v (range (* n d))]
        (clear-used)
        (when (dfs v)
          (+= num 1)
          (when (= num p)
            (print (inc (// v d)))
            (setv num -1) ;; Founded Flag
            (break))
          ))
      (when (!= num -1)
        (print "impossible"))
      ))
  )

(defmain
  [&rest args]
  (solve))


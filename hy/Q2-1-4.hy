#!/usr/bin/env hy

;; ----------------------------------------
;; 迷路の最短路
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(def data
  ["10 10"
   "#S######.#"
   "......#..#"
   ".#.##.##.#"
   ".#........"
   "##.##.####"
   "....#....#"
   ".#######.#"
   "....#....."
   ".####.###."
   "....#...G#"
   ])

(def +INF+ 100000000)

(defclass P []
  [x 0
   y 0]
  (defn --init-- [self x y]
    (setv self.x x)
    (setv self.y y)))

(defn create-matrix [n m]
  (list (map list (partition (* [+INF+] (* n m)) m))))
(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))
(defn nthm [matrix row col]
  (nth (nth matrix row) col))
(defn find-element [_list elm]
  ;; 存在すればindex, 存在しなければNoneを返す
  (try
    (.index _list elm)
    (except [e ValueError]
            None)))
(defn find-start-and-goal []
  (def start [])
  (def goal [])
  (def row 0)
  (for [line +maze+]
    (def ss (find-element line "S"))
    (when (not (none? ss))
      (setv start [row ss]))
    (def gg (find-element line "G"))
    (when (not (none? gg))
      (setv goal [row gg]))
    (setv row (inc row))
    )
  [start goal]
  )

(def +TMP+ (list (map int (.split (nth data 0)))))
(def +N+ (nth +TMP+ 0))
(def +M+ (nth +TMP+ 1))
(def +maze+ (list (map list (cut data 1))))

(def +d+ (create-matrix +N+ +M+))

(def +dx+ [1 0 -1 0])
(def +dy+ [0 1 0 -1])


(import [lib.queue [Queue]])
(defn bfs []
  (setv que (Queue))
  (def check-points (find-start-and-goal))
  (def start (first check-points))
  (def goal (second check-points))
  (def sx (first start))
  (def sy (second start))
  (def gx (first goal))
  (def gy (second goal))
  (.push que (P sx sy))
  (setm! +d+ sx sy 0)
  (loop []
    (when (not (.empty? que))
      (def p (.pop que))
      (if (and (= gx p.x)
               (= gy p.y))
        (nthm +d+ gx gy) ;; break
        (for [i (range 4)]
          (def nx (+ p.x (nth +dx+ i)))
          (def ny (+ p.y (nth +dy+ i)))
          (when (and (<= 0 nx)
                     (< nx +N+)
                     (<= 0 ny)
                     (< ny +M+)
                     (!= "#" (nthm +maze+ nx ny))
                     (= +INF+ (nthm +d+ nx ny)))
            (.push que (P nx ny))
            (setm! +d+ nx ny (inc (nthm +d+ p.x p.y)))
            (recur)))))))

(defn solve []
  (def res (bfs))
  (print res))

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; 迷路の最短路
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
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

(setv +INF+ 100000000)

(defclass P []
  [x 0
   y 0]
  (defn --init-- [self x y]
    (setv self.x x)
    (setv self.y y))
  (defn --str-- [self]
    (.format "[{0}, {1}]" (. self x) (. self y))))

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
  (setv start [])
  (setv goal [])
  (setv row 0)
  (for [line +maze+]
    (setv ss (find-element line "S"))
    (when (not (none? ss))
      (setv start [row ss]))
    (setv gg (find-element line "G"))
    (when (not (none? gg))
      (setv goal [row gg]))
    (setv row (inc row))
    )
  [start goal]
  )

(setv +TMP+ (list (map int (.split (nth data 0)))))
(setv +N+ (nth +TMP+ 0))
(setv +M+ (nth +TMP+ 1))
(setv +maze+ (list (map list (cut data 1))))

(setv +d+ (create-matrix +N+ +M+))

(setv +dx+ [1 0 -1 0])
(setv +dy+ [0 1 0 -1])


(import [lib.queue [Queue]])
(defn bfs []
  (setv que (Queue))
  (setv check-points (find-start-and-goal))
  (setv start (first check-points))
  (setv goal (second check-points))
  (setv sx (first start))
  (setv sy (second start))
  (setv gx (first goal))
  (setv gy (second goal))
  (.push que (P sx sy))
  (setm! +d+ sx sy 0)
  (loop []
    (when (not (.empty? que))
      (setv p (.pop que))
      (if (and (= gx p.x)
               (= gy p.y))
        (nthm +d+ gx gy) ;; break
        (do
          (for [i (range 4)]
            (setv nx (+ p.x (nth +dx+ i)))
            (setv ny (+ p.y (nth +dy+ i)))
            (when (and (<= 0 nx)
                       (< nx +N+)
                       (<= 0 ny)
                       (< ny +M+)
                       (!= "#" (nthm +maze+ nx ny))
                       (= +INF+ (nthm +d+ nx ny)))
              (.push que (P nx ny))
              (setm! +d+ nx ny (inc (nthm +d+ p.x p.y)))))
          (recur))))))

(defn solve []
  (setv res (bfs))
  (print res))

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; The Year of Code Jam
;; ----------------------------------------
(import sys)
(import [lib.dinic [max-flow add-edge]])
;(import [lib.fordfullkerson [max-flow add-edge]])
(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 8 (毎月2日)
  (setv N 3)
  (setv M 3)
  (setv cld [".?."
             ".?."
             ".#."])
  (, N M cld))

(defn parameter2 []
  ;; Answer : 42
  (setv N 5)
  (setv M 8)
  (setv cld [".#...##."
             ".##..?.."
             ".###.#.#"
             "??#..?.."
             "###?#..."])
  (, N M cld))

(setv +mod+ 100007)

(defn solve []
  ;; Parameters
  (setv (, N M cld) (parameter2))

  ;; Main
  (setv dx [-1 0 0 1])
  (setv dy [0 -1 1 0])

  (setv res 0)
  (setv s (* N M))
  (setv t (inc s))
  (for [i (range N)]
    (for [j (range M)]
      (if (even? (+ i j))
        (do
          (if (= (get cld i j) "#")
            (do
              (+= res 4)
              (add-edge s (+ (* i M) j) +inf+))
            (if (= (get cld i j) ".")
              (add-edge (+ (* i M) j) t +inf+)
              (do
                (+= res 4)
                (add-edge s (+ (* i M) j) 4))))
          (for [k (range 4)]
            (setv i2 (+ i (get dx k)))
            (setv j2 (+ j (get dy k)))
            (when (and (<= 0 i2)
                       (< i2 N)
                       (<= 0 j2)
                       (< j2 M))
              (add-edge (+ (* i M) j) (+ (* i2 M) j2) 2))))
        (if (= (get cld i j) "#")
          (do
            (+= res 4)
            (add-edge (+ (* i M) j) t +inf+))
          (if (= (get cld i j) ".")
            (add-edge s (+ (* i M) j) +inf+)
            (do
              (+= res 4)
              (add-edge (+ (* i M) j) t 4)))))))
  (-= res (max-flow s t))
  (print res))

(defmain
  [&rest args]
  (solve))

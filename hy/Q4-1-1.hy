#!/usr/bin/env hy

;; ----------------------------------------
;; ランダムウォーク
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [lib.operations [safe-get]])
(import [lib.matrix [gauss-jordan create-matrix]])

(defn parameter1 []
  ;; Answer : 1678.00000000
  (setv (, N M) (, 10 10))
  ;; # : 石(移動不可)
  ;; . : 移動可能なマス
  (setv grid ["..######.#"
              "......#..#"
              ".#.##.##.#"
              ".#........"
              "##.##.####"
              "....#....#"
              ".#######.#"
              "....#....."
              ".####.####"
              "....#....."])
  (, N M grid))

(defn parameter2 []
  ;; Answer : 542.10052168
  (setv (, N M) (, 10 10))
  ;; # : 石(移動不可)
  ;; . : 移動可能なマス
  (setv grid [".........."
              ".........."
              ".........."
              ".........."
              ".........."
              ".........."
              ".........."
              ".........."
              ".........."
              ".........."])
  (, N M grid))

(defn parameter3 []
  ;; Answer : 361.00000000
  (setv (, N M) (, 3 10))
  ;; # : 石(移動不可)
  ;; . : 移動可能なマス
  (setv grid [".#...#...#"
              ".#.#.#.#.#"
              "...#...#.."])
  (, N M grid))

(defn dfs [x y can-goal dx dy N M grid]
  (loop [[xx x]
         [yy y]]
    (assoc can-goal (, xx yy) True)
    (for [i (range 4)]
      (setv (, nx ny) (, (+ xx (get dx i)) (+ yy (get dy i))))
      (when (and (<= 0 nx)
                 (< nx N)
                 (<= 0 ny)
                 (< ny M)
                 (not (safe-get can-goal (, nx ny) False))
                 (!= (get grid nx ny) "#"))
        (recur nx ny)))))

(defn solve []
  ;; Parameters
  (setv (, N M grid) (parameter1))

  ;; Main
  (setv can-goal {}) ;; can-goal[x][y]がTrueなら(x,y)からゴールに到達できる
  (setv (, dx dy) (, [-1 1 0 0] [0 0 -1 1]))
  (setv A (create-matrix (* N M) (* N M) 0))
  (setv b (* [0] (* N M)))
  (dfs (dec N) (dec M) can-goal dx dy N M grid)

  ;; 行列の構築
  (for [x (range N)]
    (for [y (range M)]
      ;; ゴールにいる場合または(x,y)からゴールに到達できない場合
      (when (or (and (= x (dec N))
                     (= y (dec M)))
                (not (safe-get can-goal (, x y) False)))
        (assoc (get A (+ (* x M) y)) (+ (* x M) y) 1)
        (continue))

      ;; ゴール以外
      (setv move 0)
      (for [k (range 4)]
        (setv (, nx ny) (, (+ x (get dx k)) (+ y (get dy k))))
        (when (and (<= 0 nx)
                   (< nx N)
                   (<= 0 ny)
                   (< ny M)
                   (= (get grid nx ny) "."))
          (assoc (get A (+ (* x M) y)) (+ (* nx M) ny) -1)
          (+= move 1)))
      (assoc b (+ (* x M) y) move)
      (assoc (get A (+ (* x M) y)) (+ (* x M) y) move)))
  (setv res (gauss-jordan A b))
  (print (.format "{0:.8f}" (get res 0)))
  )

(defmain
  [&rest args]
  (solve))

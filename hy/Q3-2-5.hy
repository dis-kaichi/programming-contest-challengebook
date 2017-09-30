#!/usr/bin/env hy

;; ----------------------------------------
;; Fliptile
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-if ap-pipe]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(def data
  ["4 4"
   "1 0 0 1"    ;; 0 0 0 0
   "0 1 1 0"    ;; 1 0 0 1
   "0 1 1 0"    ;; 1 0 0 1
   "1 0 0 1"])  ;; 0 0 0 0

;; 隣接するマスの座標
(def +dx+ [-1 0 0 0 1])
(def +dy+ [0 -1 0 1 0])

(defn create-matrix [n m &optional default]
  (ap-pipe (* [default] (* n m))
           (partition it m)
           (map list it)
           (list it)))

(defn nthm [matrix row col]
  (-> matrix
      (nth row)
      (nth col)))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(def (, +max-n+ +max-m+) [15 15])
;; 最適解保存用
(def *opt* (create-matrix +max-m+ +max-n+))
;; 作業用
(def *flip* (create-matrix +max-m+ +max-n+))

(defn split-with-space [x]
  (.split x " "))

(defn map-int [x]
  (list (map int x)))

(defn debug [x]
  (print x)
  x)
(defn non-zero? [x] ((comp not zero?) x))

;; (x, y)の色を調べる
(defn get-color [tile M N x y]
  (loop [[d 0]
         [c (nthm tile x y)]]
    (if (>= d 5)
      (% c 2)
      (do
        (setv (, x2 y2) [(+ x (nth +dx+ d)) (+ y (nth +dy+ d))])
        (if (and (<= 0 x2) (< x2 M) (<= 0 y2) (< y2 N))
          (recur (inc d) (+ c (nthm *flip* x2 y2)))
          (recur (inc d) c))))))

(defn last-rows-white? [tile M N]
  (loop [[i 0]]
    (if (>= i N)
      True
      (if (non-zero? (get-color tile M N (dec M) i))
        False
        (recur (inc i))))))

;; 1行目を決めた場合の最小操作回数を求める
;; 解が存在しない場合は-1
(defn calc [tile N M]
  ;; 2行目からのひっくり返し方を求める
  (for [i (range 1 M)]
    (for [j (range N)]
      (when (non-zero? (get-color tile M N (dec i) j))
        ;; (i - 1, j)が黒色なら、このマスをひっくり返すしかない
        (setm! *flip* i j 1))))
  ;; 最後の行が全部空白かチェック
  (if (not (last-rows-white? tile N M))
    -1
    (loop [[i 0]
           [j 0]
           [res 0]]
      (if (and (>= i M) (>= j N))
        res
        (recur (inc i) (inc j) (+ res (nthm *flip* i j)))))))

(defn clear-flip []
  (for [i (range +max-m+)]
    (for [j (range +max-n+)]
      (setm! *flip* i j 0))))

(defn deep-copy-flip-to-opt []
  (for [i (range +max-m+)]
    (for [j (range +max-n+)]
      (setm! *opt* i j (nthm *flip* i j)))))

(defn solve []
  ;; Parameters
  (setv (, M N) (ap-pipe
                  data
                  (first it)
                  (.split it " ")
                  (map int it)))
  (setv tile (ap-pipe
               data
               (rest it)
               (map split-with-space it)
               (map map-int it)
               (list it)))
  ;; Main
  ;; 1行目を辞書順で全通り試す
  (setv res -1)
  (for [i (range (<< 1 N))]
    (clear-flip)
    (for [j (range N)]
      (setm! *flip* 0 (- N j 1) (& (>> i j) 1)))
    (setv num (calc tile N M))
    (when (and (>= num 0)
               (or (< res 0) (> res num)))
      (setv res num)
      (deep-copy-flip-to-opt)))

  (if (< res 0)
    (print "IMPOSSIBLE") ;; 解なし
    (for [i (range M)]
      (print (ap-pipe (nth *opt* i)
                      (map str it)
                      (take N it)
                      (list it)
                      (.join " " it))))))

(defmain
  [&rest args]
  (solve))
k

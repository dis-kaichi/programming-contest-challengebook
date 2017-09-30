#!/usr/bin/env hy

;; ----------------------------------------
;; 座標圧縮
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(require [hy.extra.anaphoric [ap-pipe]])
(import [functools [partial]])
(import [math [floor sqrt pow]])
(import [heapq [heappush heappop]])

(def data
  ["10 10 5"
   "1 1 4 9 10"
   "6 10 4 9 10"
   "4 8 1 1 6"
   "4 8 10 5 10"]) ;; 6

(defn map-int [x] (list (map int x)))

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

(defn compress [x1 x2 w N W]
  (setv xs [])
  (for [i (range N)]
    (for [d (range -1 (inc 1))]
      (setv tx1 (+ (nth x1 i) d))
      (setv tx2 (+ (nth x2 i) d))
      (when (and (<= 1 tx1) (<= tx1 W))
        (.append xs tx1))
      (when (and (<= 1 tx2) (<= tx2 W))
        (.append xs tx2))))
  (setv xs (-> xs set list))
  (.sort xs)
  (for [i (range N)]
    (assoc x1 i (.index xs (nth x1 i)))
    (assoc x2 i (.index xs (nth x2 i))))
  (len xs))

(def +dx+ [1 0 -1 0])
(def +dy+ [0 1 0 -1])

(defn solve []
  ;; Parameters
  (setv (, W H N) (-> data first (.split " ") map-int))
  (setv x1 (-> data (nth 1) (.split " ") map-int))
  (setv x2 (-> data (nth 2) (.split " ") map-int))
  (setv y1 (-> data (nth 3) (.split " ") map-int))
  (setv y2 (-> data (nth 4) (.split " ") map-int))
  ;; Main
  ;; 塗りつぶし用
  (setv fld (create-matrix (* N 6) (* N 6) False))
  ;; 座標圧縮
  (setv W (compress x1 x2 W N W))
  (setv H (compress y1 y2 H N W))
  ;; 線のある部分を塗りつぶし
  (for [i (range N)]
    (for [y (range (nth y1 i) (inc (nth y2 i)))]
      (for [x (range (nth x1 i) (inc (nth x2 i)))]
        (setm! fld y x True))))
  ;; 領域を数える
  (setv ans 0)
  (for [y (range H)]
    (for [x (range W)]
      (when (nthm fld y x)
        (continue))
      (+= ans 1)
      ;; 幅優先検索
      (setv que [])
      (.append que [x y])
      (while (not (empty? que))
        (setv (, sx sy) (-> que (.pop 0)))
        (for [i (range 4)]
          (setv tx (+ sx (nth +dx+ i)))
          (setv ty (+ sy (nth +dy+ i)))
          (when (or (< tx 0) (<= W tx) (< ty 0) (<= H ty))
            (continue))
          (when (nthm fld ty tx) (continue))
          (.append que [tx ty])
          (setm! fld ty tx True)))))
  (print ans))

(defmain
  [&rest args]
  (solve))


#!/usr/bin/env hy

;; ----------------------------------------
;; Coneology
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [math [sqrt]])
(import [lib.operations [LoopEnd unique]])
(import [lib.matrix [transpose create-matrix]])
(import [lib.point [Point on-segment? intersection]])

(setv +g+ 9.8) ;; 重力加速度
(setv +eps+ (** 10 -10))

(defn parameter1 []
  ;; Answer : 2
  ;;          3 5 (最も外周の円は2個、3番目と5番目)
  (setv N 5)
  (setv (, x y r) (-> [[0 -2 1]
                       [0 3 3]
                       [0 0 10]
                       [0 1.5 1]
                       [50 50 10]]
                      transpose))
  (, N x y r))

;; 円iが円jの内側にあるか判定
(defn inside? [i j x y r]
  (setv dx (- (get x i) (get x j)))
  (setv dy (- (get y i) (get y j)))
  (<= (+ (* dx dx) (* dy dy))
      (* (get r i) (get r j))))

(defn lower-bound [xs value &optional [lower 0] [upper -1]]
  (when (= -1 upper)
    (setv upper (len xs)))

  (loop [[lb lower]
         [ub upper]]
    (if (<= (- ub lb) 1)
      ub
      (do
        (setv mid (truncate-div (+ lb ub) 2))
        (if (>= (nth xs mid) value)
          (recur lb mid)
          (recur mid ub))))))

(defn solve []
  ;; Parameters
  (setv (, N x y r) (parameter1))

  ;; Main

  ;; イベントを列挙
  (setv events [])
  (for [i (range N)]
    (.append events [(- (get x i) (get r i)) i])        ;; 円の左側
    (.append events [(+ (get x i) (get r i)) (+ i N)])) ;; 円の右側
  (.sort events)

  ;; 平面走査
  (setv outers [])
  (setv res [])
  (for [i (range (len events))]
    (setv id (% (second (get events i)) N))
    (if (< (second (get events i)) N)
      ;; 左端の場合
      (do
        (setv index (lower-bound outers (Point (get y id) id)))
        (when (and (!= index (len outers))
                   (inside? id (. (get outers index) y) x y r))
          (continue))
        (when (and (!= index 0)
                   (inside? id (. (get outers (dec index)) y) x y r))
          (continue))
        (.append res id)
        (.append outers (Point (get y id) id))
        (setv outers (unique outers)))
      ;;右端の場合
      (do
        (try
          (.remove outers (Point (get y id) id))
          (except [e ValueError])))))

  (.sort res)
  (print (len res))
  (print (.join " " (map (fn [x] (str (+ x 1))) res))))

(defmain
  [&rest args]
  (solve))


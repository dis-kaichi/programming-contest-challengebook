#!/usr/bin/env hy

;; ----------------------------------------
;; Evacuation Plan2
;; ----------------------------------------
(import sys)
(import [lib.mincost [add-edge min-cost-flow get-graph]])
(import [lib.matrix [transpose create-matrix]])
(import [lib.operations [LoopEnd]])

(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : SUBOPTIMAL
  ;;          3 0 1 1
  ;;          0 0 6 0
  ;;          0 4 0 1
  (setv (, N M) (, 3 4))
  (setv (, X Y B) (-> [[-3 3 5]
                       [-2 -2 6]
                       [2 2 5]]
                      transpose))
  (setv (, P Q C) (-> [[-1 1 3]
                       [1 1 4]
                       [-2 -2 7]
                       [0 -1 3]]
                      transpose))
  (setv E [[3 1 1 0]
           [0 0 6 0]
           [0 3 0 2]])
  (, N M X Y B P Q C E))

(defn solve []
  ;; Paramters
  (setv (, N M X Y B P Q C E) (parameter1))

  ;; Main
  (setv V (+ N M 1))
  ;; 距離行列の計算
  (setv g (create-matrix V V +inf+)) ;; 距離行列
  (setv prev (create-matrix V V))    ;; 最短路の直前の頂点
  (setv used {})                     ;; ループ検出フラグ

  (for [j (range M)]
    (setv sum 0)
    (for [i (range N)]
      (setv c (+ (abs (- (get X i) (get P j)))
                 (abs (- (get Y i) (get Q j)))
                 1))
      (assoc (get g i) (+ N j) c)
      (when (pos? (get E i j))
        (assoc (get g (+ N j)) i (- c)))
      (+= sum (get E i j)))
    (when (pos? sum)
      (assoc (get g (+ N M)) (+ N j) 0))
    (when (< sum (get C j))
      (assoc (get g (+ N j)) (+ N M) 0)))

  ;; ワーシャルフロイド法により負閉路検出を行う
  (for [i (range V)]
    (for [j (range V)]
      (assoc (get prev i) j i)))

  (setv optimal? True)
  (try
    (for [k (range V)]
      (for [i (range V)]
        (for [j (range V)]
          (when (> (get g i j)
                   (+ (get g i k) (get g k j)))
            (assoc (get g i) j (+ (get g i k) (get g k j)))
            (assoc (get prev i) j (get prev k j))
            (when (and (= i j)
                       (neg? (get g i i)))
              (setv used (* [False] V))
              ;; 負閉路が存在
              (setv v i)
              (while (not (get used v))
                (assoc used v True)
                (when (and (!= v (+ N M))
                           (!= (get prev i v) (+ N M)))
                  (if (>= v N)
                    (do
                      (setv (, x y) (, (get prev i v) (- v N)))
                      (assoc (get E x) y (inc (get E x y))))
                    (do
                      (setv (, x y) (, v (- (get prev i v) N)))
                      (assoc (get E x) y (dec (get E x y))))) )))
            (print "SUBOPTIMAL")
            (for [x (range N)]
              (print (.join " " (map str (get E x)))))
            (setv optimal? False)
            (raise LoopEnd)))))
    (except [e LoopEnd])) ;; 無理やり多重ループを抜ける
  (when optimal?
    (print "OPTIMAL")))

(defmain
  [&rest args]
  (solve))


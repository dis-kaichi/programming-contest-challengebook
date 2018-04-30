#!/usr/bin/env hy

;; ----------------------------------------
;; Evacuation Plan
;; ----------------------------------------
(import sys)
(import [lib.mincost [add-edge min-cost-flow get-graph]])
(import [lib.matrix [transpose]])

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

  ;; マッチンググラフの作成
  ;; 0~N-1    : ビル
  ;; N~N+M-1  : シェルター
  (setv s (+ N M))
  (setv t (inc s))
  (setv V (inc t))
  (setv cost 0) ;; 避難計画のコスト総和を計算
  (setv F 0)    ;; 人の総和
  (for [i (range N)]
    (for [j (range M)]
      (setv c (+ (abs (- (get X i) (get P j)))
                 (abs (- (get Y i) (get Q j)))
                 1))
      (add-edge i (+ N j) +inf+ c)
      (+= cost (* (get E i j) c))))
  (for [i (range N)]
    (add-edge s i (get B i) 0)
    (+= F (get B i)))
  (for [i (range M)]
    (add-edge (+ N i) t (get C i) 0))

  (if (< (min-cost-flow V s t F) cost)
    ;; 最適でない場合
    (do
      (print "SUBOPTIMAL")
      (setv G (get-graph))
      (for [i (range N)]
        (setv path [])
        (for [j (range M)]
          (setv cap (. (get (get G (+ N j)) i) cap))
          (.append path cap))
        (print (.join " " (map str path)))))
    ;; 最適な場合
    (print "OPTIMAL")))

(defmain
  [&rest args]
  (solve))


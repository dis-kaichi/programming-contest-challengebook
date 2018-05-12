#!/usr/bin/env hy

;; ----------------------------------------
;; K-Anonymous Sequence
;; ----------------------------------------
(import [lib.operations [safe-get]])

(defn parameter1 []
  ;; Answer : 3 (2, 2, 2, 4, 4, 4, 4)
  (setv n 7)
  (setv k 3)
  (setv a [2 2 3 4 4 5 5])
  (, n k a))

(setv *dp* {})
(setv *S* {})

;; 直線f_jのxにおける値
(defn f [a j x]
  (+ (* (- (get a j)) x)
     (safe-get *dp* j 0)
     (- (get *S* j))
     (* (get a j) j)))

;; f2が最小値を取る可能性があるか判定
(defn check [f1 f2 f3]
  (setv a1 (- (get a f1)))
  (setv b1 (+ (safe-get *dp* f1 0)
              (- (get *S* f1))
              (* (get a f1) f1)))
  (setv a2 (- (get a f2)))
  (setv b2 (+ (safe-get *dp* f2 0)
              (- (get *S* f2))
              (* (get a f2) f2)))
  (setv a3 (- (get a f3)))
  (setv b3 (+ (safe-get *dp* f3 0)
              (- (get *S* f3))
              (* (get a f3) f3)))
  (>= (* (- a2 a1) (- b3 b2))
      (* (- b2 b1) (- a3 a2))))


(defn solve []
  (global *S*)
  (global *dp*)
  ;; Parameters
  (setv (, n k a) (parameter1))

  ;; Main
  (setv deq {})

  ;; 和の計算
  (assoc *S* 0 0)
  (for [i (range n)]
    (assoc *S* (inc i) (+ (get *S* i) (get a i))))

  ;; デックの初期化
  (setv (, s t) (, 0 1))
  (assoc deq 0 0)

  (assoc *dp* 0 0)

  (for [i (range k (inc n))]
    (when (>= (- i k) k)
      ;; 末尾から最小値を取る可能性がなくなったものを取り除く
      (while (and (< (inc s) t)
                  (check (get deq (- t 2))
                         (get deq (- t 1))
                         (- i k)))
        (-= t 1))

      ;; デックにi-kを追加
      (assoc deq t (- i k))
      (+= t 1))

    ;; 先頭が最小値でなければ取り除く
    (while (and (< (inc s) t)
                (>= (f a (get deq s) i)
                    (f a (get deq (inc s)) i)))
      (+= s 1))

    (assoc *dp* i (+ (get *S* i)
                     (f a (get deq s) i))))
  (print (get *dp* n)))

(defmain
  [&rest args]
  (solve))


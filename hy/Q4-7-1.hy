#!/usr/bin/env hy

;; ----------------------------------------
;; 禁止文字列
;; ----------------------------------------
(import [lib.string [substring]])

(setv +agct+ "AGCT")
(setv +mod+ 10009)

(defn parameter1 []
  ;; Answer : 56
  (setv (, n k S) (, 3 2 "AT"))
  (, n k S))

(setv *next* {}) ;; 1文字加えた際に移動する先の状態
(setv *dp* {})

(defn solve []
  (global *next*)
  (global *dp*)
  ;; Parameters
  (setv (, N K S) (parameter1))

  ;; Main

  ;; 前処理
  (for [i (range K)]
    (for [j (range 4)]
      ;; 一致しているi文字に1文字加えた文字列
      (setv s (+ (substring S 0 i) (get +agct+ j)))
      ;; Sの先頭に一致するまで先頭から1文字削る
      (while (!= (substring S 0 (len s)) s)
        (setv s (substring s 1)))
      (assoc *next* (, i j) (len s))))

  ;; 動的計画法の初期状態
  (assoc *dp* (, 0 0) 1)
  (for [i (range 1 K)]
    (assoc *dp* (, 0 i) 0))
  ;; 動的計画法
  (for [t (range N)]
    (for [i (range K)]
      (assoc *dp* (, (inc t) i) 0))
    (for [i (range K)]
      (for [j (range 4)]
        (setv ti (get *next* (, i j)))
        (when (= ti K)
          (continue)) ;; Sが出現してしまうのでダメ
        (assoc *dp* (, (inc t) ti)
               (% (+ (get *dp* (, (inc t) ti))
                     (get *dp* (, t i)))
                  +mod+)))))

  (setv ans 0)
  (for [i (range K)]
    (setv ans (% (+ ans (get *dp* (, N i))) +mod+)))
  (print ans))

(defmain
  [&rest args]
  (solve))


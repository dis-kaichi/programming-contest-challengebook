#!/usr/bin/env hy

;; ----------------------------------------
;; DNA Repair
;; ----------------------------------------
(import sys)
(import [lib.string [substring]])
(import [lib.operations [unique]])
(import [lib.search [lower-bound]])

(setv +agct+ "AGCT")
(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 1
  (setv S "AAAG")
  (setv P ["AAA" "AAG"])
  (, S P))

(defn parameter2 []
  ;; Answer : 4
  (setv S "TGAATG")
  (setv P ["A" "TG"])
  (, S P))

(defn parameter3 []
  ;; Answer : -1
  (setv S "AGT")
  (setv P ["A" "G" "C" "T"])
  (, S P))

(setv *next* {}) ;; 1文字加えた際に移動する先の状態
(setv *ng* {})  ;; 到達してはいけない状態であるか
(setv *dp* {})

(defn solve []
  (global *next*)
  (global *dp*)
  (global *ng*)
  ;; Parameters
  (setv (, S P) (parameter1))
  (setv N (len P))

  ;; Main

  ;; まずは先頭となる文字列をすべて列挙
  (setv pfx [])
  (for [i (range N)]
    (for [j (range (inc (len (get P i))))]
      (.append pfx (substring (get P i) 0 j))))
  ;; ソートし、重複を取り除く
  (setv pfx (unique pfx))
  (.sort pfx)
  (setv K (len pfx))

  ;; 各状態の情報を計算
  (for [i (range K)]
    ;; 末尾が禁止パターンに一致していたらこの状態は到達しては行けない状態
    (assoc *ng* i False)
    (for [j (range N)]
      (setv cond1 (<= (len (get P j))
                      (len (get pfx i))))
      (setv cond2 (= (substring (get pfx i)
                                (- (len (get pfx i))
                                   (len (get P j)))
                                (len (get P j)))
                     (get P j)))
      (assoc *ng* i (or (get *ng* i)
                        (and cond1 cond2))))
    (for [j (range 4)]
      ;; 1文字加えた文字列
      (setv s (+ (get pfx i) (get +agct+ j)))
      ;; 先頭から1文字ずつ削りつつ、一致する文字列が状態にあれば、それが移動先の状態
      (setv k -1)
      (while True
        (setv k (lower-bound pfx s))
        (when (and (< k K)
                   (= (get pfx k) s))
          (break))
        (setv s (substring s 1)))
      (assoc *next* (, i j) k)))

  ;; 動的計画法の初期化
  (assoc *dp* (, 0 0) 1)
  (for [i (range 1 K)]
    (assoc *dp* (, 0 i) 0))
  ;; 動的計画法
  (for [t (range (len S))]
    (for [i (range K)]
      (assoc *dp* (, (inc t) i) +inf+))

    (for [i (range K)]
      (when (get *ng* i)
        (continue))
      (for [j (range 4)]
        (setv k (get *next* (, i j)))
        (assoc *dp* (, (inc t) k) (min (get *dp* (, (inc t) k))
                                       (+ (get *dp* (, t i))
                                          (if (= (get S t) (get +agct+ j)) 0 1)))))))

  (setv ans +inf+)
  (for [i (range K)]
    (when (get *ng* i)
      (continue))
    (setv ans (min ans (get *dp* (, (len S) i)))))
  (if (= ans +inf+)
    (print -1)
    (print ans)))

(defmain
  [&rest args]
  (solve))


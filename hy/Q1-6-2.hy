#!/usr/bin/env hy

;; ----------------------------------------
;; Ants (POJ No.1852)
;; ----------------------------------------
(import [lib.inpututils [split-with-space map-int]])

(defn solver [data]
  ;; Parameter
  (setv L (-> data first int))
  (setv n (-> data second int))
  (setv x (-> data (nth 2) split-with-space map-int))
  ;; Main
  ;; 最小の時間を計算
  (setv min-t 0)
  (for [i (range n)]
    (setv min-t (max min-t (min (get x i) (- L (get x i))))))
  ;; 最大の時間を計算
  (setv max-t 0)
  (for [i (range n)]
    (setv max-t (max max-t (max (get x i) (- L (get x i))))))
  (, min-t max-t))

(defn solve []
  (setv data1
        ["10"
         "3"
         "2 6 7"])
  ;;
  (setv (, min-time max-time) (solver data1))
  (print min-time max-time))

(defmain
  [&rest args]
  (solve))


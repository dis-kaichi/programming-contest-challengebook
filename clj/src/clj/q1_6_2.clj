(ns clj.q1-6-2)

;; ----------------------------------------
;; Ants (POJ No.1852)
;; ----------------------------------------

(defn calc-min-time [L n x]
  (loop [i 0
         t 0]
    (if (< i n)
      (recur (inc i) (max t (min (nth x i) (- L (nth x i)))))
      t)))

(defn calc-max-time [L n x]
  (loop [i 0
         t 0]
    (if (< i n)
      (recur (inc i) (max t (max (nth x i) (- L (nth x i)))))
      t)))

(defn solver [L n x]
  ;; 最小の時間を計算
  (def min-t (calc-min-time L n x))
  ;; 最大の時間を計算
  (def max-t (calc-max-time L n x))
  [min-t max-t])

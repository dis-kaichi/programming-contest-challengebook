(ns clj.q2-3-1)
;; ----------------------------------------
;; 01ナップサック問題
;; ----------------------------------------

(defn rec [n ws vs i j]
  (if (= i n)
    0
    (if (< j (nth ws i))
      (rec n ws vs (inc i) j)
      (apply max [(rec n ws vs (inc i) j)
                  (+ (rec n ws vs (inc i) (- j (nth ws i)))
                     (nth vs i))]))))

(defn solver [n W ws vs]
  (rec n ws vs 0 W))


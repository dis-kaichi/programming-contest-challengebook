(ns clj.q2-3-2)
;; ----------------------------------------
;; 01ナップサック問題
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set!]])
(def ^:dynamic *dp* (atom {}))

(defn rec [n ws vs i j]
  (if (>= (deep-get @*dp* i j -1) 0)
    (deep-get @*dp* i j)
    (if (= i n)
      (do
        (deep-set! *dp* i j 0)
        0)
      (if (< j (nth ws i))
        (do
          (def x (rec n ws vs (inc i) j))
          (deep-set! *dp* i j x)
          x)
        (do
          (def x (apply max [(rec n ws vs (inc i) j)
                             (+ (rec n ws vs (inc i) (- j (nth ws i)))
                                (nth vs i))]))
          (deep-set! *dp* i j x)
          x)))))

(defn solver [n W ws vs]
  (reset! *dp* {})
  (rec n ws vs 0 W))


(ns clj.q2-3-3)
;; ----------------------------------------
;; 01ナップサック問題
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn solver [n W ws vs]
  (loop [i (dec n)
         j (nth ws i)
         dp {}]
    (if (< i 0)
      (deep-get dp 0 W 0)
      (if (> j W)
        (recur (dec i) 0 dp)
        (if (< j (get ws i))
          (recur i (inc j) (deep-set dp i j (deep-get dp (inc i) j 0 )))
          (recur i (inc j) (deep-set dp i j (max (deep-get dp (inc i) j 0)
                                                 (+ (deep-get dp (inc i) (- j (get ws i)) 0)
                                                    (get vs i))))))))))


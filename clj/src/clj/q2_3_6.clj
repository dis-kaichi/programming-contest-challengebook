(ns clj.q2-3-6)
;; ----------------------------------------
;; 個数制限なしナップサック問題
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn solver [n W ws vs]
  (loop [i 0
         j 0
         dp {}]
    (if (>= i n)
      (deep-get dp n W 0)
      (if (> j W)
         (recur (inc i) 0 dp)
         (if (< j (nth ws i))
           (recur i (inc j) (deep-set dp (inc i) j (deep-get dp i j 0)))
           (recur i (inc j) (deep-set dp (inc i) j (max (deep-get dp i j 0)
                                                        (+ (deep-get dp (inc i) (- j (nth ws i)) 0)
                                                           (nth vs i))))))))))



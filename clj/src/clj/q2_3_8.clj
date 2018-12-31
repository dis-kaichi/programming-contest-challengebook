(ns clj.q2-3-8)
;; ----------------------------------------
;; 個数制限なしナップサック問題(1次元配列Ver)
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn solver [n W ws vs]
  (loop [i 0
         j (nth ws i)
         dp {}]
    (if (>= i n)
      (get dp W)
      (if (> j W)
        (recur (inc i) (get ws (inc i) 0) dp)
        (recur i (inc j) (assoc dp j (max (get dp j 0)
                                          (+ (get dp (- j (nth ws i)) 0)
                                             (nth vs i)))))))))

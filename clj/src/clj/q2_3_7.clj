(ns clj.q2-3-7)
;; ----------------------------------------
;; 01ナップサック問題(1次元配列Ver)
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn solver [n W ws vs]
  (loop [i 0
         j W
         dp {}]
    (if (>= i n)
      (get dp W)
      (if (>= j (nth ws i))
        (recur i (dec j) (assoc dp j (max (get dp j 0)
                                          (+ (get dp (- j (nth ws i)) 0)
                                             (nth vs i)))))
        (recur (inc i) W dp)))))


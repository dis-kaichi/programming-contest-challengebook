(ns clj.q2-3-12)
;; ----------------------------------------
;; 個数制限付き部分和問題(Ver2)
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn calc-max [i as dp]
  (loop [j 0
         dp dp]
    (if (>= j i)
      dp
      (if (< (nth as j) (nth as i))
        (recur (inc j) (assoc dp i (max (get dp i)
                                        (+ (get dp j) 1))))
        (recur (inc j) dp)))))

(defn solver [n as]
  (loop [i 0
         res 0
         dp {}]
    (if (>= i n)
      res
      (do
        (def dp2 (calc-max i as (assoc dp i 1)))
        (recur (inc i) (max res (get dp2 i)) dp2)
        ))))


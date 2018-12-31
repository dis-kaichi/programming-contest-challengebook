(ns clj.q2-3-5)
;; ----------------------------------------
;; 個数制限なしナップサック問題
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn solver [n W ws vs]
  (loop [i 0
           j 0
           k 0
           dp {}]
    (if (>= i n)
      (deep-get dp n W)
      (if (> j W)
        (recur (inc i) 0 0 dp)
        (if (<= (* k (nth ws i)) j)
          (recur i j (inc k) (deep-set dp (inc i) j
                                       (max (deep-get dp (inc i) j 0)
                                            (+ (deep-get dp i (- j (* k (nth ws i))) 0)
                                               (* k (nth vs i))))))
          (recur i (inc j) 0 dp))))))


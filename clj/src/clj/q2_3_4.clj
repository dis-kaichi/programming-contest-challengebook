(ns clj.q2-3-4)
;; ----------------------------------------
;; 最長共通部分列問題
;; ----------------------------------------

(require '[clojure.string :as string])
(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn solver [n m ss tt]
  (def s (string/split ss #""))
  (def t (string/split tt #""))
  (loop [i 0
         j 0
         dp {}
           ]
    (if (>= i n)
      (deep-get dp n m 0)
      (if (>= j m)
        (recur (inc i) 0 dp)
        (if (= (get s i) (get t j))
          (recur i (inc j) (deep-set dp (inc i) (inc j)
                                     (+ (deep-get dp i j 0) 1)))
          (recur i (inc j) (deep-set dp (inc i) (inc j)
                                     (max (deep-get dp i (inc j) 0)
                                          (deep-get dp (inc i) j 0))))
          )))))


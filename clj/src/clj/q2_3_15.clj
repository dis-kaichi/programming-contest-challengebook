(ns clj.q2-3-15)
;; ----------------------------------------
;; 最長増加部分列問題(Ver2)
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])
(require '[clj.lib.search :refer [lower-bound]])

;(def +inf+ Integer/MAX_VALUE)

(defn create-array [n & {:keys [d] :or {d 0}}]
  (loop [i 0
         xs []]
    (if (>= i n)
      xs
      (recur (inc i) (conj xs d)))))

(defn solver [n as]
  (loop [i 0
           dp (create-array n)]
    (if (>= i n)
      (- (lower-bound dp n) 1)
      (recur (inc i) (assoc dp
                            (- (lower-bound dp (nth as i)) 1)
                            (nth as i))))))


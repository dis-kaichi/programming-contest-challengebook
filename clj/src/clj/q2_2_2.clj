(ns clj.q2-2-2)
;; ----------------------------------------
;; 区間スケジューリング
;; ----------------------------------------
(require '[clj.lib.vector :refer [zip]])

(defn solver [n s t]
  (def itv (-> [t s]
               (->> (apply zip))
               sort
               (->> (into []))))
  (loop [
         ans 0
         tt 0
         i 0]
    (if (< i n)
      (if (< tt (-> itv (get i) second))
        (recur (inc ans) (-> itv (get i) first) (inc i))
        (recur ans tt (inc i)))
      ans)))

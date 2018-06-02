(ns clj.q1-6-3)

;; ----------------------------------------
;; くじびき : O(n^3 logn) version
;; ----------------------------------------
(require '[clj.lib.search :refer [binary-search]])

(defn check-elements [n m k]
  (for [a (range n)
          b (range n)
          c (range n)]
    (binary-search k (- m (nth k a) (nth k b) (nth k c)))))

(defn solver [n m k]
  (if (some true? (check-elements n m k))
    "Yes"
    "No"))

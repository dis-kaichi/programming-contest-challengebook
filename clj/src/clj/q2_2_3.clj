(ns clj.q2-2-3)
;; ----------------------------------------
;; Best Cow Line
;; ----------------------------------------
(require '[clojure.string :refer [join split]])
(require '[clj.lib.vector :refer [zip]])

(defn left? [s a b]
  (loop [i 0]
    (def sa (get s (+ a i)))
    (def sb (get s (- b i)))
    (if (<= (+ a i) b)
      (if (< (compare sa sb) 0)
        true
        (if (> (compare sa sb) 0)
          false
          (recur (inc i))))
      false)))

(defn solver [n s]
  (def ss (split s #""))
  (loop [a 0
         b (dec n)
         ans []]
    (if (<= a b)
      (if (left? ss a b)
        (recur (inc a) b (conj ans (get ss a)))
        (recur a (dec b) (conj ans (get ss b))))
      (->> ans (map str) (join "")))))
